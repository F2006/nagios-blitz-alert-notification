# Nagios Blitz Alert push notification

Inspired by the Slack Nagios plugin to send Nagios alerts to Slac, here is a Nagios plugin to send push notification alerts to Blitz Alert (http://www.blitzalert.me/)

Setup

Copy the blitz_nagios.sh bash file, I have used /usr/local/bin

Add these commands to your commands.cfg

```
###############################
# Blitz Alert notifications
###############################

# 'notify-service-by-blitz' command definition
define command {
       command_name     notify-service-by-blitz
       command_line      /usr/local/bin/blitz_nagios.sh \
                                          "$HOSTNAME$" \
                                          "$SERVICEDESC$" \
                                          "$SERVICESTATE$" \
                                          "$SERVICEOUTPUT$" \
                                          "$NOTIFICATIONTYPE$"
       }

# 'notify-host-by-blitz' command definition
define command {
       command_name     notify-host-by-blitz
       command_line      /usr/local/bin/blitz_nagios.sh \
                                          "$HOSTNAME$" \
                                          "$HOSTDESC$" \
                                          "$HOSTSTATE$" \
                                          "$HOSTOUTPUT$" \
                                          "$NOTIFICATIONTYPE$"
       }
```

Add the following contact to your contacts.cfg

```
define contact {
       contact_name                     blitz
       alias                            Blitz
       service_notification_period      24x7
       host_notification_period         24x7
       service_notification_options     w,u,c,r
       host_notification_options        d,r
       service_notification_commands    notify-service-by-blitz
       host_notification_commands       notify-host-by-blitz
       }
```

Add the blitz contact to your contact groups contacts.cfg

```
define contactgroup{
        contactgroup_name       admins
        alias                   Nagios Administrators
        members                 root,blitz
        }

define contactgroup{
        contactgroup_name       admins-page
        alias                   Nagios Administrators
        members                 root,blitz
        }
```
