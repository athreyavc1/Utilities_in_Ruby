require 'sinatra'
require 'active_record'
require 'rubygems'

ActiveRecord::Base.establish_connection(
 :adapter => "mysql2",
 :host => "localhost",
 :database =>"sakila",
 :username =>"root",
 :password => "classic")

class Actor < ActiveRecord::Base
  self.table_name = "actor"
end

get '/' do
 erb :home
end

get '/sample' do
  erb :sample
end

get '/about' do
  erb :about
end

__END__
@@home
<!doctype html>
<html lang="en">
   <head>
       <title>Research on WARs</title>
        <meta charset="utf-8">
   </head>
<body>
<header>
  <h1>WARS Humanity Fought</h1>
  <section>
    <p> Welcome to the site </p>
  </section>
  <nav>
    <ul>
      <li><a href="/" title="Home">Home</a></li>
      <li><a href="/about" title="About">About</a></li>
      <li><a href="/contact" title="Contact">Contact</a></li>
      <li><a href="/sample" title="Sample">Sample</a></li>
    </ul>
</header>
</body>
</html>
@@about
<html lang="en">
 <body>
    <h1>Soon to be created</h1>
  </body>
</html>
@@sample
<html lang="en">
<body>
  <h1>List of Actor</h1>
  <table>
  <th> First Name </th>
  <tr>
  <% Actor.all.each do | line | %>
  <tr>
    <td> <%= line.first_name %> </td>
    </tr>
  <% end %>

</table>
</body>
</html<
