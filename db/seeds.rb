# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)



User.create(name: '管理者', email: 'admin@example.com', password: '1234', image: 'default.jpg', admin: true)
User.create(name: 'Example', email: 'user@example.com', password: '1111', image: '1_face.jpg')
User.create(name: 'Keisuke', email: 'kei@gmail.com', password: '1111', image: '2_face.jpg')
User.create(name: 'Tanaka', email: 'tanaka@gmail.com', password: '1111', image: '3_face.jpg')
User.create(name: 'Itou', email: 'itou@gmail.com', password: '1111', image: '4_face.jpg')
User.create(name: 'Komami', email: 'komami@gmail.com', password: '1111', image: '5_face.jpg')
User.create(name: 'Aoyama', email: 'mi@gmail.com', password: '1111', image: '6_face.jpg')
User.create(name: 'Tamaki', email: 'tamaki@gmail.com', password: '1111', image: '7_face.jpg')
User.create(name: 'Sugi', email: 'tamaka@gmail.com', password: '1111', image: '8_face.jpg')
User.create(name: 'Tonbayashi', email: 'tamakb@gmail.com', password: '1111', image: '9_face.jpg')
User.create(name: 'Gotou', email: 'tamakc@gmail.com', password: '1111', image: '10_face.jpg')

Post.create(title: '素晴らしい時計を購入', content: '値段はそんなに高くないけど、最近買ってよかったものでNo1　すごく使いやすいし、革がまたおしゃれ', user_id: 1, post_image: '1_post.jpg')
Post.create(title: 'シンプルでおしゃれな椅子に憧れて', content: '貝殻みたいな形が好き。座りごごちもよく、これに座ると次第に眠くなってしまう。。。', user_id: 3, post_image: '2_post.jpg')
Post.create(title: '雰囲気重視！', content: 'シンプルなものこそ意外に良いものだったりする。まさにこの椅子は木だけで組まれていて、他に装飾は一切なし！でもそれが大切にしようと思うのかも、、、。', user_id: 4, post_image: '3_post.jpg')
Post.create(title: 'レトロなカメラって最高', content: 'チェキとか流行っているけど、それにつられてレトロカメラを買ってしまった。これを持ち出してから、外に出ることが多くなって健康も気にするようになった！', user_id: 5, post_image: '4_post.jpg')
Post.create(title: '字にも変化がでてきた！', content: 'こんなかっこいいペンを持っていたら、やっぱり自分の書く字にも気を使ってしまう。', user_id: 6, post_image: '5_post.jpg')
Post.create(title: '朝の一杯が最高の時間', content: '白いマグカップは汚れが目立つこともある(特にコーヒーを入れるとなると、、、)。でも、その分愛着が湧く。朝こうやってコーヒーを飲める時間を大切にしたい。', user_id: 7, post_image: '6_post.jpg')
Post.create(title: 'Macbookで仕事が捗るように。', content: 'カフェでmacbookを開いている人を少しへんな目で見てたけど、まさか自分がなってしまうとは、、、。でも、その代わりこれに似合う自分になろうとしてる気がして仕事も捗っている。Thank you!', user_id: 8, post_image: '7_post.jpg')
Post.create(title: '一風変わったグラス', content: '少し高かったグラス。でもコーヒーを入れると、とてもよく映える。これは上が甘くて、下が苦い部分に分かれてる。自分の飲み方で甘さが調整できる面白い飲みのも。グラスのせいかさらに美味しく感じた。', user_id: 9, post_image: '8_post.jpg')
Post.create(title: '彼氏にもらったピアス', content: 'あまり丸型のピアスはつけないけれど、つけてみると案外いい感じだった。何か思い出があるものは大切にしたくなる。', user_id: 10, post_image: '9_post.jpg')

Post.create(title: 'ナイフを買った', content: 'オレンジを切ってみたけど、切れ味はとてもよかった。意外とナイフって買い換えることないけど、家事のストレスとかなくなるし、もっと料理をしたいって思えるようになったかも。', user_id: 8, post_image: '10_post.jpg')
Post.create(title: 'ライブにいきました', content: '買ったものは「ライブチケット」確かに手元に置いたりできる「もの」ではないから、あげようか迷ったけど、思い出が「もの」だとしたらこれもありかなって、、、。', user_id: 10, post_image: '11_post.jpg')
Post.create(title: 'ベースを購入', content: 'ギターとベースどちらを買おうか迷ったけど、結局ベースになりました。白いボディに一目惚れ！ただ、弦がギターよりも高いのがうーんって感じ。今日から自分の音楽人生がスタートです！', user_id: 5, post_image: '12_post.jpg')