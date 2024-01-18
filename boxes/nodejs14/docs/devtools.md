# Development tools

This devbox comes pre-installed with a number of useful tools for development and system administration, including:

- [curl](//curl.haxx.se/)
- [Git](//git-scm.com/)
- [MailDev](//github.com/djfarrelly/MailDev)
- [Ngrok](//ngrok.com/)
- [Yarn](//yarnpkg.com/)

Instructions to use some of these tools are provided below.

## MailDev

[MailDev](//github.com/djfarrelly/MailDev) is an application that captures outgoing emails sent from other applications running on the same system, rather than letting the emails be delivered to their intended recipients. The captured outbound emails can be viewed in a web-based inbox.

The MailDev does not start automatically at boot-up. To start it, SSH into the devbox and run the command `maildev`.

MailDev exposes a web interface on port 1080. To access that web interface externally from the VM, you will need to configure Nginx to route certain requests to that port. For example, you could point the host "mail.devbox.localhost" to the IP address of your devbox, and then an Nginx server will route those requests to http://127.0.0.1:1080 internally. See the [example provisioning script](//github.com/kieranpotts/devboxes/blob/latest/dev/boxes/nodejs14/example/boot/inc/srv/nginx/maildev.sh) for guidance.

## Ngrok

Ngrok is an easy-to-use, lightweight tool that creates a secure tunnel between your local machine and a public URL that you or anyone else can use to browse your locally-developed website or web app. When Ngrok is running, it listens on the same port that your local HTTP server is running on, and proxies external requests to it.

To use Ngrok you will need to [sign-up for an account](//dashboard.ngrok.com/signup). When you've done that, see the [documentation](//ngrok.com/docs) for instructions to use the service.
