class PostController < Sinatra:: Base

  set :root, File.join(File.dirname(__FILE__),"..")

  set :view, Proc.new { File.join(root,"views") }

  configure:development do
    register Sinatra::Reloader
  end

  $songs = [

    {
      id:0,
      title: "First song",
      body: "this is the body of the first song.",
      embed_id: "8AALadVkzyA"
    },

    {
      id:1,
      title: "second song",
      body: "this is the body of the second song.",
      embed_id: "5sb1mLK8Wok"
    },

    {
      id:2,
      title:"third song",
      body:"this is the body of the third song.",
      embed_id: "haA7DpK9Z4k"
    }
  ]

  get "/" do
    @title_index = "Homepage"
    @songs = $songs
    erb :'posts/index'
  end

  get "/new" do
    @songs = {
      id:"",
      title:"",
      body:""
    }
    erb :'posts/new'
  end
  
  # have to create a post so it know what to do with that info (new song)
post "/" do
  new_song = {
    id:$songs.length,
    title: params[:title],
    body: params[:body]
  }
  $songs.push new_song
  redirect "/"
end

  # this is to get songs to appear on the page when you click show
  get "/:id_URL" do
    id = params[:id_URL].to_i
    @songs =$songs[id]
    erb :'posts/show'
  end

  # editing
  get '/:id_URL/edit' do
    id = params[:id_URL].to_i
    @songs = $songs[id]
    erb :'posts/edit'
  end

  # editing. what to put the new info
  put '/:id' do
    id = params[:id].to_i
    songs = $songs[id]
    # changes songs title to title in form. so in name it must be the same
    songs[:title] = params[:title]
    songs[:body]  = params[:body]
    redirect '/'
  end
# delete
  delete '/:id' do
    id = params[:id].to_i
    $songs.delete_at(id)
    redirect '/'
  end

end
