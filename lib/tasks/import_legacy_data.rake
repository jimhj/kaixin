namespace :legacy do
  desc "导入老站数据"
  task import: :environment do
    ActiveRecord::Base.transaction do
        puts "============ 开始导入用户数据 ===============\n"

      imported_uids = Legacy::User.all.map.with_index do |user, i|
        puts "导入第 #{i+1} 个用户...\n"
        # puts user.as_json
        # puts "\n"

        u                   = User.new
        u.id                = user.id
        u.login             = user.name
        u.email             = user.email
        u.password_digest   = user.password_digest
        if user.avatar.present?
          u.remote_avatar_url = user.avatar_url
        end
        u.confirmed         = true
        u.created_at        = user.created_at
        u.updated_at        = user.updated_at
        u.save(validate: false)
        u.id
      end

        puts "============ 开始导入笑话数据 ===============\n"

      imported_jids = Legacy::Joke.where(user_id: imported_uids).map.with_index do |joke, i|
        puts "导入第 #{i+1} 个笑话...\n"

        j                    = Joke.new
        j.id                 = joke.id
        j.user_id            = joke.user_id
        j.title              = joke.title
        j.content            = joke.content
        j.remote_photos_urls = [joke.picture_url]
        j.anonymous          = false
        j.up_votes_count     = joke.up_votes_count
        j.down_votes_count   = joke.down_votes_count
        j.comments_count     = joke.comments_count
        j.hot                = joke.hot
        j.approved_at        = joke.published_at
        j.created_at         = joke.created_at
        j.updated_at         = joke.updated_at
        j.recommended        = joke.recommended
        j.save(validate: false)

        joke.tags.each do |tag|
          t                 = ::Tag.find_or_create_by! name: tag.name
          t.seo_title       = tag.seo_title
          t.seo_description = tag.description
          t.seo_keywords    = tag.keywords
          t.save(validate: false)
          
          j.tags << t
        end

        j.id
      end

        puts "============ 开始导入评论数据 ===============\n"

      Legacy::Comment.where(joke_id: imported_jids).map.with_index do |comment, i|
        puts "导入第 #{i+1} 个评论...\n"

        c                  = Comment.new
        c.commentable_type = "Joke"
        c.commentable_id   = comment.joke_id
        c.up_votes_count   = rand(100)
        c.body             = comment.body
        c.user_id          = imported_uids.sample
        c.save(validate: false)
      end
    end
  end
end