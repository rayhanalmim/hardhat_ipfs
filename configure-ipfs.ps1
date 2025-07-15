# Configure IPFS CORS Headers
ipfs config --json API.HTTPHeaders.Access-Control-Allow-Origin '["http://localhost:3000", "http://localhost:3001", "http://127.0.0.1:3000", "http://127.0.0.1:3001"]'
ipfs config --json API.HTTPHeaders.Access-Control-Allow-Methods '["PUT", "POST", "GET"]'
ipfs config --json API.HTTPHeaders.Access-Control-Allow-Headers '["Authorization", "X-Requested-With", "Range", "User-Agent"]'
ipfs config --json API.HTTPHeaders.Access-Control-Expose-Headers '["Location", "Ipfs-Hash"]'
ipfs config --json API.HTTPHeaders.Access-Control-Allow-Credentials '["true"]'

# Show the updated configuration
ipfs config show 