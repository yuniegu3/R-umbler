User.create(first_name:"Yunie", last_name:"Han", password: 123 , email: "yunie@mail.com" , birth_date: "1993-04-09")

Blog.create(user_id: 1, blog_name: "Test Blog 1")


Post.create(blog_id: 1, post_name: "Test Post 1", content: "I HOPE YOU WORK!!!!")
Post.create(blog_id: 1, post_name: "Test Post 2", content: "I HOPE YOU WORK!!!! - you dont have a tag")

Tag.create(tag_name: "Test111")

Post_tag.create(post_id: 1, tag_id:1)
