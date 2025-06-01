$TTL 86400
@   IN  SOA ns1.adminsiteanars.com. admin.adminsiteanars.com. (
            2025052901 ; Serial
            3600       ; Refresh
            1800       ; Retry
            604800     ; Expire
            86400 )    ; Negative Cache TTL

@   IN  NS      ns1.adminsiteanars.com.
ns1 IN  A       10.89.0.2
@   IN  A       10.89.0.2
www IN  A       10.89.0.2

