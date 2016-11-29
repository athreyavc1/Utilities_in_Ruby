require 'sinatra'

get '/' do
 erb :home
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
