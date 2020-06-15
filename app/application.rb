class Application

  @@items = ["Apples","Carrots","Pears"]

  @@cart = [ ]

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    
    if req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
      end

    elsif req.path.match(/search/)
      search_term = req.params["q"]
      resp.write handle_search(search_term)

    elsif req.path.match(/cart/)
      if @@cart.length == 0 
        resp.write "Your cart is empty"
      else
        resp.write "#{@@cart.join("\n")}"
      end

    elsif req.path.match(/add/)
      item = req.params["item"]
      if @@items.include?(item)
        @@cart << item
        resp.write "added #{item}"
      else
        resp.write "We don't have that item"
      end
    else
      resp.write "Path Not Found"
    end

    resp.finish
  end
  def handle_search(search_term)
      return "Couldn't find #{search_term}"
    end
  end


end