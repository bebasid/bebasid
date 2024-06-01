name: Laporkan Bug
description: Laporkan bug mengenai situs.
title: '[BUG] example.com'
labels: 
  - bug
  - sites
assignees: 
  - ryukora
body:
  - type: markdown
    attributes:
      value: Terima kasih telah melaporkan masalah! Pastikan website yang akan dilaporkan tidak terdapat duplikat atau belum dibuka issue oleh pengguna lain
  - type: input
    id: deskripsi
    attributes:
      label: Deskripsi mengenai bug
      description: Deskripsi yang jelas dan ringkas tentang apa yang terjadi.
      placeholder: Deskripsikan masalah di sini...
    validations:
      required: true
  - type: textarea
    id: screenshot
    attributes:
      label: Screenshot
      description: Jika ada, tambahkan ss untuk membantu menjelaskan mengenai bug.
      placeholder: Tambahkan tautan atau deskripsi mengenai screenshot di sini...
  - type: input
    id: os
    attributes:
      label: Device
      description: OS
      placeholder: cth. Windows 11, Mac OS X
    validations:
      required: true
  - type: input
    id: browser
    attributes:
      label: Browser
      description: Browser
      placeholder: cth. Chrome, Firefox, Edge
    validations:
      required: true
