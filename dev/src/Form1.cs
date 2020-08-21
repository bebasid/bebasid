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
    public partial class Form1 : Form
    {
        public static bool IsAdministrator()
        {
            using (WindowsIdentity identity = WindowsIdentity.GetCurrent())
            {
                WindowsPrincipal principal = new WindowsPrincipal(identity);
                return principal.IsInRole(WindowsBuiltInRole.Administrator);
            }
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

        public static bool isSFW()
        {
            string firstLine;
            using (StreamReader reader = new StreamReader(Environment.GetEnvironmentVariable("SystemRoot") + "/System32/drivers/etc/hosts"))
            {
                firstLine = reader.ReadLine() ?? "";
            }
            if (firstLine.Contains("Safe for Work"))
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        public static bool isNSFW()
        {
            string firstLine;
            using (StreamReader reader = new StreamReader(Environment.GetEnvironmentVariable("SystemRoot") + "/System32/drivers/etc/hosts"))
            {
                firstLine = reader.ReadLine() ?? "";
            }
            if (firstLine.Contains("BEBASID"))
            {
                return true;
            }
            else
            {
                return false;
            }

        }

        public void setDefaultValues()
        {
            if (isBebasidInstalled())
            {
                statusHostsValue.Text = "Terpasang";
                if (isSFW())
                {
                    labelTypeHostsValue.Text = "SFW";
                    buttonChangeTypeHosts.Text = "NSFW Mode";
                }
                else
                {
                    if (isNSFW())
                    {
                        labelTypeHostsValue.Text = "NSFW";
                        buttonChangeTypeHosts.Text = "SFW Mode";
                    }
                    else
                    {
                        labelTypeHostsValue.Text = "-";
                    }
                        
                }
                btnInstall.Enabled = false;
                btnUpdateHosts.Enabled = true;
                buttonChangeTypeHosts.Enabled = true;
                btnUninstallHosts.Enabled = true;
            }
            else
            {
                labelTypeHostsValue.Text = "-";
                statusHostsValue.Text = "Tidak Terpasang";
                btnInstall.Enabled = true;
                btnUpdateHosts.Enabled = false;
                buttonChangeTypeHosts.Enabled = false;
                btnUninstallHosts.Enabled = false;
            }
        }

        public Form1()
        {
            InitializeComponent();
            if (!IsAdministrator())
            {
                MessageBox.Show("Aplikasi ini membutuhkan hak admin, silakan buka dengan opsi 'Run as Administrator'", "bebasid");
                Environment.Exit(0);
            }
            setDefaultValues();
        }

        public void disableButton()
        {
            btnUpdateHosts.Enabled = false;
            buttonChangeTypeHosts.Enabled = false;
            btnUninstallHosts.Enabled = false;
        }

        public void enableButton()
        {
            btnUpdateHosts.Enabled = true;
            buttonChangeTypeHosts.Enabled = true;
            btnUninstallHosts.Enabled = true;
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
                MessageBox.Show("Tidak dapat melakukan flush DNS", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
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
            for (int i = start; i < finish; i++)
            {
                progressBar1.Value = i;
                Thread.Sleep(100);
            }
        }

        private void startDownload(string link)
        {
            disableButton();
            installationStatus.Text = "Mengecek koneksi dengan internet";
            loading(1, 25);
            Thread thread = new Thread(() => {
                if (checkConnection())
                {
                    installationStatus.Text = "Komputer terhubung dengan internet";
                    Thread.Sleep(500);
                    WebClient client = new WebClient();
                    client.DownloadProgressChanged += new DownloadProgressChangedEventHandler(client_DownloadProgressChanged);
                    client.DownloadFile(new System.Uri(link), Environment.GetEnvironmentVariable("SystemRoot") + "/System32/drivers/etc/hosts");
                    Thread.Sleep(1000);
                    installationStatus.Text = "Berhasil memasang hosts bebasid";
                    Thread.Sleep(500);
                    installationStatus.Text = "Melakukan Flush DNS";
                    loading(60, 80);
                    if (ngeFlush())
                    {
                        installationStatus.Text = "Berhasil melakukan flush DNS";
                        Thread.Sleep(500); 
                        installationStatus.Text = "Finalisasi";
                        setDefaultValues();
                        loading(80, 100);
                        progressBar1.Value = 100;
                        enableButton();
                    }
                }
                else
                {
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
                double percentage = (bytesIn / totalBytes * 35) + 25;
                installationStatus.Text = "Sedang mengunduh hosts bebasid";
                progressBar1.Value = int.Parse(Math.Truncate(percentage).ToString());
            });
        }

        private void btnInstall_Click(object sender, EventArgs e)
        {
            Form2 form2 = new Form2();
            form2.ShowDialog();
        }

        private void buttonChangeTypeHosts_Click(object sender, EventArgs e)
        {
            if (isSFW())
            {
                var bebasidKonfirmasi = MessageBox.Show("Dengan menekan tombol ya, tipe hosts akan diubah ke mode NSFW, apakah anda yakin ingin tetap melakukannya",
                "Konfirmasi",
                MessageBoxButtons.YesNo, MessageBoxIcon.Question);
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
                            MessageBox.Show("Berhasil mengganti tipe hosts bebasid ke NSFW", "Success", MessageBoxButtons.OK, MessageBoxIcon.Information);
                        }
                    });
                    suk.Start();
                }
            }
            else
            {
                var bebasidKonfirmasi = MessageBox.Show("Dengan menekan tombol ya, tipe hosts akan diubah ke mode SFW, apakah anda yakin ingin tetap melakukannya",
                "Konfirmasi",
                MessageBoxButtons.YesNo, MessageBoxIcon.Question);
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
                            MessageBox.Show("Berhasil mengganti tipe hosts bebasid ke SFW", "Success", MessageBoxButtons.OK, MessageBoxIcon.Information);
                        }
                    });
                    suk.Start();
                }
            }
        }

        private void linkAbout_LinkClicked(object sender, LinkLabelLinkClickedEventArgs e)
        {
            About form3 = new About();
            form3.ShowDialog();
        }

        private void btnUninstallHosts_Click(object sender, EventArgs e)
        {
            progressBar1.Value = 0;
            var bebasidKonfirmasi = MessageBox.Show("Dengan menekan tombol ya, hosts bebasid akan dihapus, apakah anda yakin ingin tetap melakukannya?",
                "Konfirmasi",
                MessageBoxButtons.YesNo, MessageBoxIcon.Question);
            if (bebasidKonfirmasi == DialogResult.Yes)
            {
                new Thread(() =>
                {
                    try
                    {
                        Thread.CurrentThread.IsBackground = true;
                        progressBar1.Value = 25;
                        installationStatus.Text = "Menghapus file hosts";
                        File.Delete(Environment.GetEnvironmentVariable("SystemRoot") + "/System32/drivers/etc/hosts");
                        Thread.Sleep(1000);
                        progressBar1.Value = 50;
                        installationStatus.Text = "Mengaktifkan hosts backup";
                        File.Move(Environment.GetEnvironmentVariable("SystemRoot") + "/System32/drivers/etc/hosts-bebasid.bak", Environment.GetEnvironmentVariable("SystemRoot") + "/System32/drivers/etc/hosts");
                        Thread.Sleep(1000);
                        progressBar1.Value = 100;
                        installationStatus.Text = "Berhasil menghapus bebasid";
                    }
                    finally
                    {
                        setDefaultValues();
                        MessageBox.Show("bebasid berhasil dihapus", "Success", MessageBoxButtons.OK, MessageBoxIcon.Information);
                    }
                }).Start();
            }
        }

        private void btnUpdateHosts_Click(object sender, EventArgs e)
        {
            if (isSFW())
            {
                var bebasidKonfirmasi = MessageBox.Show("Apakah anda yakin ingin mengupdate hosts bebasid?","Konfirmasi",MessageBoxButtons.YesNo, MessageBoxIcon.Question);
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
                            MessageBox.Show("Berhasil memperbarui hosts bebasid", "Success", MessageBoxButtons.OK, MessageBoxIcon.Information);
                        }
                    });
                    suk.Start();
                }
            }
            else
            {
                var bebasidKonfirmasi = MessageBox.Show("Apakah anda yakin ingin mengupdate hosts bebasid?", "Konfirmasi", MessageBoxButtons.YesNo, MessageBoxIcon.Question);
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
                            MessageBox.Show("Berhasil mengupdate hosts bebasid", "Success", MessageBoxButtons.OK, MessageBoxIcon.Information);
                        }
                    });
                    suk.Start();
                }
            }
        }
    }
}
