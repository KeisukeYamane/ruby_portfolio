# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Post.create(title: '今日はいい天気', content: '本当にいい天気', user_id: 1, post_image: '3_chare.jpeg')
Post.create(title: '今日はgoodな天気', content: '本当にgoodな天気', user_id: 1, post_image: '3_chare.jpeg')
Post.create(title: '今日は悪い天気', content: '本当に悪い天気', user_id: 2, post_image: '3_chare.jpeg')
Post.create(title: '今日はbad天気', content: '本当にbad天気', user_id: 2, post_image: '3_chare.jpeg')
Post.create(title: '今日はbetterな天気', content: '本当にbetterな天気', user_id: 3, post_image: '3_chare.jpeg')
Post.create(title: '今日は眠たい天気', content: '本当に眠たい天気', user_id: 4, post_image: '3_chare.jpeg')
Post.create(title: '今日は朝顔な天気', content: '本当に朝顔な天気', user_id: 5, post_image: '3_chare.jpeg')
Post.create(title: '今日はbな天気', content: '本当にbな天気', user_id: 4, post_image: '3_chare.jpeg')


User.create(name: '管理者', email: 'admin@gmail.com', password: '1111', image: 'default.png', admin: true)
User.create(name: 'kei', email: 'keisuke@gmail.com', password: '1111', image: 'image_1.png')
User.create(name: 'けい', email: 'kei@gmail.com', password: '1111', image: 'image_2.png')
User.create(name: '田中', email: 'tanaka@gmail.com', password: '1111', image: 'image_3.png')
User.create(name: '伊藤', email: 'itou@gmail.com', password: '1111', image: 'image_4.png')
User.create(name: '駒見', email: 'komami@gmail.com', password: '1111', image: 'image_5.png')
User.create(name: '見', email: 'mi@gmail.com', password: '1111', image: 'image_6.png')
User.create(name: 'tamaki', email: 'tamaki@gmail.com', password: '1111', image: 'image_7.png')
User.create(name: 'tamaki', email: 'tamaka@gmail.com', password: '1111', image: 'image_7.png')
User.create(name: 'tamaki', email: 'tamakb@gmail.com', password: '1111', image: 'image_7.png')
User.create(name: 'tamaki', email: 'tamakc@gmail.com', password: '1111', image: 'image_7.png')
