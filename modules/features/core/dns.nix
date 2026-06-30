{ ... }:
{
  flake.modules.nixos.dns =
    { lib, ... }:
    {
      services.resolved = {
        enable = true;
        settings.Resolve = {
          DNSSEC = "allow-downgrade";
          DNSOverTLS = "true";
        };
      };

      # "#cloudflare-dns.com" suffix sets the TLS SNI for cert validation.
      networking.nameservers = [
        "1.1.1.1#cloudflare-dns.com"
        "1.0.0.1#cloudflare-dns.com"
      ];

      # Prevents NM from pushing DHCP DNS to resolved — Cloudflare DoT only, no network overrides.
      # mkForce needed because the resolved module otherwise sets this to "systemd-resolved".
      networking.networkmanager.dns = lib.mkForce "none";
    };
}
