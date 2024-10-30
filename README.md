# anonysubs
Anonysubs is a robust tool for uncovering live subdomains and sub-subdomains of any target domain. Built for speed and precision, it’s ideal for security pros and researchers needing a clear view of a domain’s active web assets, revealing hidden entry points and enhancing security insights with fast, reliable results.

requirements : sudo apt update && sudo apt install -y sublist3r && sudo apt install -y golang-go && git clone https://github.com/projectdiscovery/subfinder.git && cd subfinder/v2/cmd/subfinder && go install && cd ../../.. && wget https://github.com/findomain/findomain/releases/latest/download/findomain-linux && chmod +x findomain-linux && sudo mv findomain-linux /usr/local/bin/findomain && git clone https://github.com/tomnomnom/assetfinder.git && cd assetfinder && go build && sudo mv assetfinder /usr/local/bin/ && cd .. && rm -rf subfinder assetfinder && echo "All tools installed!"



