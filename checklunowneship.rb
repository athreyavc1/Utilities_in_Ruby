#!/usr/bin/ruby

require 'colorize'
require 'optparse'
require 'terminal-table'

######################################################################
##################################################################################################################################################
##	Check Pool LUN Ownership 
##
##	lists the pool luns and their current default, and allocated owner
##		current - the SP that currently owns the LUN
##		default - the SP that the LUN normally lives on
##		allocated - the SP that the LUN was initially created on
##
##	Written by 	Wandering Generalist
##	Logic taken from a Perl Script of the same name Written by Mat Harvest
##################################################################################################################################################
##
##
## Revision Control
## 0.1	initial release
##
##################################################################################################################################################
##################################################################################################################################################


options = { :array_ip => nil, :user_id => nil, :password => nil, :scope => nil }

 OptionParser.new do|opts|

                opts.banner = "Usage: checklunowneship.rb [options]"

                opts.on('-a','--array_ip IP Address', "IP address of the Array".colorize(:yellow)  ) { |array_ip|
                                options[:array_ip] = array_ip

                }
                opts.on('-u','--user_id UserID',  "User ID to login to the array".colorize(:yellow) ) { |user_id|
                                options[:user_id]=user_id
                }

                opts.on('-p','--password Password',  "Password to login".colorize(:yellow)) { |password|
                                options[:password]=password
                }

                opts.on('-s','--scope Scope',  "Scope of the User".colorize(:yellow)) {|scope|
                                options[:scope]=scope
                }

                opts.on('-h','--help', 'Displays Help'.colorize(:yellow), 'Help') do
                        puts opts
                        exit
                end
end.parse!()


if  options[:array_ip] == nil
        puts "Array IP Address is missing!!!".colorize(:red)
	puts "checklunowneship.rb --array_ip IP Address --password Password --scope Scope".colorize(:yellow) 
        exit
end

if  options[:user_id] == nil
        puts "User Name is missing!!!".colorize(:red)
	puts "checklunowneship.rb --array_ip IP Address --password Password --scope Scope".colorize(:yellow)
	exit
end

if options[:password] == nil
        puts  "Password is missing !!!".colorize(:red)
        puts "checklunowneship.rb --array_ip IP Address --password Password --scope Scope".colorize(:yellow)
	exit
end

if options[:scope] == nil
        puts "Scope entry for the User is missing!!!".colorize(:red)
	puts "checklunowneship.rb --array_ip IP Address --password Password --scope Scope".colorize(:yellow)
	exit
end

arrayip=options[:array_ip]
username=options[:user_id]
passwd=options[:password]
scope_id=options[:scope]


owners=`/opt/Navisphere/bin/naviseccli -h "#{arrayip}" -user "#{username}" -password "#{passwd}" -scope "#{scope_id}"  lun -list -isPoolLUN -alOwner -owner -default`
stats=owners.split("\n\n")
lundetails=Struct.new(:LUNID, :LUNName, :CurrentOwner, :AllocationOwner, :DefaultOwner, :Status, :TressPassed)
fm=[]
stats.each do | line |
        lunID=line.split("\n")[0].split(" ")[3].to_s
        lunName=line.split("\n")[1].gsub('Name:  ','')
        curOwner=line.split("\n")[2].split(":")[1].strip
        allocOwner=line.split("\n")[4].split(":")[1].strip
        defOwner=line.split("\n")[3].split(":")[1].strip
        if curOwner == defOwner && defOwner == allocOwner
                line = lunID + "," + lunName + "," + curOwner + "," + allocOwner + "," + defOwner +"," +  "Optimal" + "," + "No"
                fm << line
        else
                line = lunID + "," + lunName + "," + curOwner + "," + allocOwner + "," + defOwner +"," +  "Non Optimal" + "," + "yes"
                fm << line
        end

end


format = '%-15s %-8s %-7s %-7s %-7s %s'


table = Terminal::Table.new :title => "LUN OWNERSHIP REPORT", :headings=> ["LUNID", "LUNName", "CurrentOwner", "AllocationOwner", "DefaultOwner", "Status", "TressPassed"] do |t|
        fm.each do | l |
                t << l.split(",")
        end
end

puts table
