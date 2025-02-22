hostname {{ .ShortName }}
username admin privilege 15 secret admin
!
service routing protocols model multi-agent
!
vrf instance MGMT
!
interface Management0
   description oob_management
   vrf MGMT
{{ if .MgmtIPv4Address }}   ip address {{ .MgmtIPv4Address }}/{{ .MgmtIPv4PrefixLength }}{{end}}
{{ if .MgmtIPv6Address }}   ipv6 address {{ .MgmtIPv6Address }}/{{ .MgmtIPv6PrefixLength }}{{end}}
!
{{ if .MgmtIPv4Gateway }}ip route vrf MGMT 0.0.0.0/0 {{ .MgmtIPv4Gateway }}{{end}}
{{ if .MgmtIPv6Gateway }}ipv6 route vrf MGMT ::0/0 {{ .MgmtIPv6Gateway }}{{end}}
   no lldp receive
   no lldp transmit
!
daemon TerminAttr
   exec /usr/bin/TerminAttr -cvaddr=10.100.169.50:9910,10.100.169.51:9910,10.100.169.52:9910 -cvauth=token,/mnt/flash/token -cvvrf=MGMT -disableaaa
   no shutdown
management security
   ssl profile eAPI
      cipher-list HIGH:!eNULL:!aNULL:!MD5:!ADH:!ANULL
      certificate eAPI.crt key eAPI.key
!
management api http-commands
   protocol http
   protocol https ssl profile eAPI
   no shutdown
   !
   vrf MGMT
      no shutdown
!
end