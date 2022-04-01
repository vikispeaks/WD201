def get_command_line_argument
  # ARGV is an array that Ruby defines for us,
  # which contains all the arguments we passed to it
  # when invoking the script from the command line.
  # https://docs.ruby-lang.org/en/2.4.0/ARGF.html
  if ARGV.empty?
    puts "Usage: ruby lookup.rb <domain>"
    exit
  end
  ARGV.first
end

# `domain` contains the domain name we have to look up.
domain = get_command_line_argument

# File.readlines reads a file and returns an
# array of string, where each element is a line
# https://www.rubydoc.info/stdlib/core/IO:readlines
dns_raw = File.readlines("zone")

def singleArrayToHash(array)
    records = {}
    array.each do |item|
        records[item[1]] = { rectype: item[0], destination: item[2] }
    end
    return records
end

def parse_dns(dns_raw)
    stripped_dns = dns_raw.map do |line|
        line.strip
    end
    rejected_dns = stripped_dns.reject do |line|
        line.empty? || line[0] == "#"
    end
    selected_dns = rejected_dns.map do |line|
        line.split(", ")
    end
    filtered_dns = selected_dns.filter do |item|
        item[0] == "CNAME" || item[0] == "A"
    end
    finalDNSHash = singleArrayToHash(filtered_dns)
    return finalDNSHash
end

def resolve(dns_records, lookup_chain, domain)
    if dns_records.has_key?(domain)
        if dns_records[domain][:rectype] == "CNAME"
            lookup_chain << dns_records[domain][:destination]
            resolve(dns_records, lookup_chain, dns_records[domain][:destination])
        elsif dns_records[domain][:rectype] == "A"
            lookup_chain << dns_records[domain][:destination]
            return lookup_chain
        else
            lookup_chain << "Record Type is Undefined!!!"
        end
    else
        lookup_chain << "Domain Record does not exist!!!"
    end
end

dns_records = parse_dns(dns_raw)
lookup_chain = [domain]
lookup_chain = resolve(dns_records, lookup_chain, domain)
puts lookup_chain.join(" => ")