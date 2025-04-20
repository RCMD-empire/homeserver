
# Cups - Printer Server
Specs:
- **hardcoded Printer**, (USB Sock, VendorID),
- **container restarts** if the Printer comes back online again (if gone offline at all) with udev, separate script
- pre-defined config files
- **.env file** as variables for user:password (admin panel) **.GITIGNORE-ed**,

TODO:
- admin webUI panel doesnt let log in (reachable but disallowed by the browser) -> nginx, SSL

[**Last success (commit**)](https://github.com/RCMD-empire/homeserver/commit/a354cb008971aaaab8d506cf9dfb98f9b2e6cf87)