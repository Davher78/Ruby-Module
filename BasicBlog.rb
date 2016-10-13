class Blog	

	# Constructor de la clase
	def initialize ()
		@posts = []
	end

	def publish_front_page 
		@posts.each_with_index do |post,index|
			puts "Post #{index} title: #{post.title}"
			puts "**************"
			puts "Post #{index} text: #{post.text}"
			puts "----------------"
		end
	end	

	def put_post(post)
		@posts.push(post)
	end

end

class Post
	attr_reader :title, :date, :text
	# Constructor de la clase
	def initialize (title,date,text)
		@title = title
		@date = date
		@text = text
	end
end

date1 = Date.new 
date2 = Date.new
date3 = Date.new  

post1 = Post.new("titulo0", date1, "texto0")
post2 = Post.new("titulo1", date2, "texto1")
post3 = Post.new("titulo2", date3, "texto2")

blog = Blog.new
blog.put_post(post1)
blog.put_post(post2)
blog.put_post(post3)
blog.publish_front_page



