using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
// using System.Security.Cryptography;

// haibara

namespace bebasid
{
    public partial class About : Form
    {
        public About()
        {
            InitializeComponent();
        }

        // static string Encrypt(string value)
        // {
        //     using (MD5CryptoServiceProvider md5 = new MD5CryptoServiceProvider())
        //     {
        //         UTF8Encoding utf8 = new UTF8Encoding();
        //         byte[] data = md5.ComputeHash(utf8.GetBytes(value));
        //         return Convert.ToBase64String(data);
        //     }
        // }

        // private void linkLabel1_LinkClicked(object sender, LinkLabelLinkClickedEventArgs e)
        // {
        //     if(Encrypt(textBox1.Text) == ":)")
        //     {
        //         this.Close();
        //         Form4 form4 = new Form4();
        //         form4.ShowDialog();
        //     }
        //     else
        //     {
        //         MessageBox.Show("No problem if you don't have the Secret Key Code (SKC), because it's not affect this application. This application is 100% free without license key needed!", "Notice", MessageBoxButtons.OK, MessageBoxIcon.Information);
        //     }
        //     
        // }

        private void button1_Click(object sender, EventArgs e)
        {
            System.Diagnostics.Process.Start("https://bebasid.github.io");
        }

        private void button2_Click(object sender, EventArgs e)
        {
            System.Diagnostics.Process.Start("https://github.com/bebasid/bebasid");
        }

        private void button3_Click(object sender, EventArgs e)
        {
            System.Diagnostics.Process.Start("https://discord.gg/EKrxZyu");
        }
    }
}
