{ ... }:
{
  flake.modules.nixos.dns =
    { lib, ... }:
    {
      services.resolved = {
        enable = true;
        settings.Resolve = {
          DNSSEC = "allow-downgrade";
          # Strict DNS-over-TLS (encrypted-only). If DNS ever stalls on a
          # captive-portal wifi or a network that blocks TCP 853, switch this
          # to "opportunistic".
          DNSOverTLS = "true";
        };
      };

      # The "#cloudflare-dns.com" suffix sets the TLS server name used to
      # validate Cloudflare's certificate. resolved picks these up as its
      # global DNS= servers.
      networking.nameservers = [
        "1.1.1.1#cloudflare-dns.com"
        "1.0.0.1#cloudflare-dns.com"
      ];

      # Force Cloudflare system-wide (like the NextDNS phone app): NetworkManager
      # does DHCP/IP/routing but never feeds the network's DHCP-pushed DNS to
      # resolved, so resolved only ever uses the global Cloudflare DoT servers
      # above — networks cannot override our resolver.
      # Tradeoff: networks with internal/split DNS won't resolve their private
      # hostnames (reach those by IP), and strict DoT can stall on captive-portal
      # wifi that blocks port 853 (switch DNSOverTLS to "opportunistic", or move
      # to a local cloudflared DoH-over-443 proxy, if that becomes a problem).
      # mkForce overrides the resolved module, which otherwise sets this to
      # "systemd-resolved" (the integration that pushes per-link DNS to resolved).
      networking.networkmanager.dns = lib.mkForce "none";
    };
}
