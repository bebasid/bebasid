using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using System.IO;
using System.Security.Principal;
using System.Net;
using System.Threading;
using System.Diagnostics;

// haibara

namespace bebasid
{
    public partial class Form2 : Form
    {
        public Form2()
        {
            InitializeComponent();
        }

        public static bool isBebasidInstalled()
        {
            return File.Exists(Environment.GetEnvironmentVariable("SystemRoot") + "/System32/drivers/etc/hosts-bebasid.bak");
        }

        public static bool checkConnection()
        {
            try
            {
                using (var client = new WebClient())
                using (client.OpenRead("https://www.google.com/generate_204"))
                    return true;
            }
            catch
            {
                return false;
            }
        }

        public static bool isHostsAvailable()
        {
            return File.Exists(Environment.GetEnvironmentVariable("SystemRoot") + "/System32/drivers/etc/hosts");
        }

        public void flushDns(string arg)
        {
            Process ngeFlush = new Process();
            ngeFlush.StartInfo.UseShellExecute = false;
            ngeFlush.StartInfo.FileName = "ipconfig";
            ngeFlush.StartInfo.WindowStyle = ProcessWindowStyle.Hidden;
            ngeFlush.StartInfo.CreateNoWindow = true;
            ngeFlush.StartInfo.Arguments = arg;
            try
            {
                if (ngeFlush.Start())
                {
                    return;
                }
                else
                {
                    installationStatus.Text = "Tidak Dapat Melakukan Flush DNS";
                }
            }
            catch (Exception err)
            {
                Console.WriteLine(err.Message);
                MessageBox.Show("Tidak dapat melakukan flush DNS.", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        public bool ngeFlush()
        {
            flushDns("/flushdns");
            //flushDns("/release");
            //flushDns("/renew");
            return true;
        }
        public void loading(int start, int finish)
        {
            for( int i = start; i < finish; i++)
            {
                progressBar1.Value = i;
                Thread.Sleep(100);
            }
        }
        public void disableButton()
        {
            button1.Enabled = false;
            button2.Enabled = false;
        }
        public void enableButton()
        {
            button1.Enabled = true;
            button2.Enabled = true;
        }

        private void startDownload(string link)
        {
            disableButton();
            installationStatus.Text = "Mengecek koneksi dengan internet";
            Thread thread = new Thread(() => {
                if (checkConnection())
                {
                    loading(1, 15);
                    installationStatus.Text = "Komputer terhubung dengan internet";
                    Thread.Sleep(500);
                    if (isHostsAvailable())
                    {
                        installationStatus.Text = "Membuat backup hosts";
                        loading(15, 30);
                        File.Move(Environment.GetEnvironmentVariable("SystemRoot") + "/System32/drivers/etc/hosts", Environment.GetEnvironmentVariable("SystemRoot") + "/System32/drivers/etc/hosts-bebasid.bak");
                        installationStatus.Text = "Berhasil mengambil backup hosts";
                        Thread.Sleep(500);
                    }
                    else
                    {
                        installationStatus.Text = "Mengambil backup hosts";
                        WebClient siaa = new WebClient();
                        siaa.DownloadFileAsync(new System.Uri("https://raw.githubusercontent.com/bebasid/bebasid/master/dev/resources/hosts"), Environment.GetEnvironmentVariable("SystemRoot") + "/System32/drivers/etc/hosts-bebasid.bak");
                        loading(15, 30);
                        installationStatus.Text = "Berhasil mengambil backup hosts";
                        Thread.Sleep(500);

                    }
                    WebClient client = new WebClient();
                    client.DownloadProgressChanged += new DownloadProgressChangedEventHandler(client_DownloadProgressChanged);
                    client.DownloadFileCompleted += new AsyncCompletedEventHandler(client_DownloadFileCompleted);
                    client.DownloadFile(new System.Uri(link), Environment.GetEnvironmentVariable("SystemRoot") + "/System32/drivers/etc/hosts");
                    Thread.Sleep(1000);
                    installationStatus.Text = "Berhasil memasang hosts bebasid";
                    Thread.Sleep(500);
                    installationStatus.Text = "Melakukan Flush DNS";
                    loading(80, 90);
                    if (ngeFlush())
                    {
                        installationStatus.Text = "Berhasil melakukan flush DNS";
                        Thread.Sleep(500);
                        installationStatus.Text = "Finalisasi";
                        loading(90, 100);
                        progressBar1.Value = 100;
                        enableButton();
                    }
                }
                else
                {
                    installationStatus.Text = "Tidak dapat terhubung dengan internet";
                    MessageBox.Show("Komputer tidak terhubung dengan internet", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    enableButton();
                }
            });
            thread.Start();
            thread.Join();
        }

        void client_DownloadProgressChanged(object sender, DownloadProgressChangedEventArgs e)
        {
            this.BeginInvoke((MethodInvoker)delegate {
                double bytesIn = double.Parse(e.BytesReceived.ToString());
                double totalBytes = double.Parse(e.TotalBytesToReceive.ToString());
                double percentage = (bytesIn / totalBytes * 50) + 30;
                installationStatus.Text = "Sedang mengunduh hosts bebasid";
                progressBar1.Value = int.Parse(Math.Truncate(percentage).ToString());
            });
        }

        void client_DownloadFileCompleted(object sender, AsyncCompletedEventArgs e)
        {
            this.BeginInvoke((MethodInvoker)delegate {
                
            });
        }

        private void button1_Click(object sender, EventArgs e)
        {
            if (checkConnection())
            {
                if (!isBebasidInstalled())
                {
                    if(comboBox1.SelectedItem.ToString().Trim() == "SFW")
                    {
                        var bebasidKonfirmasi = MessageBox.Show("Dengan menekan tombol 'Yes', file hosts komputer anda akan diubah dengan hosts bebasid (SFW) dan secara langsung maupun tidak langsung, anda menyetujui aturan pemakaian yang dikeluarkan oleh tim bebasid.\n\nApakah anda yakin ingin melanjutkan pemasangan bebasid?","Konfirmasi",MessageBoxButtons.YesNo, MessageBoxIcon.Information);
                        if (bebasidKonfirmasi == DialogResult.Yes)
                        {
                            Thread suk = new Thread(() =>
                            {
                                try
                                {
                                    startDownload("https://raw.githubusercontent.com/bebasid/bebasid/master/dev/resources/hosts.sfw");
                                }
                                finally
                                {
                                    MessageBox.Show("Berhasil memasang hosts bebasid", "Success", MessageBoxButtons.OK, MessageBoxIcon.Information);
                                    Application.Restart();
                                    this.Close();
                                }
                            });
                            suk.Start();
                        }
                    }
                    else
                    {
                        var bebasidKonfirmasi = MessageBox.Show("Dengan menekan tombol 'Yes', file hosts komputer anda akan diubah dengan hosts bebasid (NSFW) dan secara langsung maupun tidak langsung, anda menyetujui aturan pemakaian yang dikeluarkan oleh tim bebasid.\n\nApakah anda yakin ingin melanjutkan pemasangan bebasid?", "Konfirmasi", MessageBoxButtons.YesNo, MessageBoxIcon.Information);
                        if (bebasidKonfirmasi == DialogResult.Yes)
                        {
                            Thread suk = new Thread(() =>
                            {
                                try
                                {
                                    startDownload("https://raw.githubusercontent.com/bebasid/bebasid/master/releases/hosts");
                                }
                                finally
                                {
                                    MessageBox.Show("Berhasil memasang hosts bebasid", "Success", MessageBoxButtons.OK, MessageBoxIcon.Information);
                                    Application.Restart();
                                    this.Close();
                                }
                            });
                            suk.Start();
                        }
                    }
                }
                else
                {
                    MessageBox.Show("bebasid telah terpasang, silakan uninstall bebasid terlebih dahulu", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                }
            }
            else
            {
                MessageBox.Show("Komputer tidak terhubung dengan internet", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void button2_Click(object sender, EventArgs e)
        {
            this.Close();
        }
    }
}
