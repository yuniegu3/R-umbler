User.create(first_name:"Yunie", last_name:"Han", password: 123 , email: "yunie@mail.com" , birth_date: "1993-04-09")
User.create(first_name:"Test", last_name:"Han", password: 12345 , email: "test@mail.com" , birth_date: "200-04-01")


Blog.create(user_id: 1, blog_name: "Yunie Test Blog 1")
Blog.create(user_id: 2, blog_name: "Test Blog 2")


Post.create(blog_id: 1, post_name: "Y Test Post 1", content: "I HOPE YOU WORK!!!! - you have tag 2")
Post.create(blog_id: 1, post_name: "Y Test Post 2", content: "I HOPE YOU WORK!!!! - you dont have a tag")
Post.create(blog_id: 2, post_name: "Test Post 1", content: "I HOPE YOU WORK!!!! - you have tag 2")
Post.create(blog_id: 2, post_name: "Test Post 1", content: "I HOPE YOU WORK!!!! - you have tag 2")
Post.create(blog_id: 2, post_name: "Test Post 1", content: "I HOPE YOU WORK!!!! - you have tag 1")



Tag.create(tag_name: "Test111")
Tag.create(tag_name: "Test222")


Post_tag.create(post_id: 1, tag_id:2)
Post_tag.create(post_id: 3, tag_id:2)
Post_tag.create(post_id: 4, tag_id:2)
Post_tag.create(post_id: 5, tag_id:1)

