namespace :users do
  namespace :add_default_images do
    desc "Add default profile image to users without a profile image"
    task profile_image: :environment do
      users = User.all

      users.each do |user|
        next if user.profile_picture.attached?

        file = File.open("#{Rails.root}/app/assets/images/default_profile_image.jpg")
        filename = "default_profile_image#{user.id}.jpg"

        user.profile_picture.attach(io: file, filename: filename)
      end
    end

    desc "Add default profile image to users without a profile image"
    task cover_image: :environment do
      users = User.all

      users.each do |user|
        next if user.cover_image.attached?

        file = File.open("#{Rails.root}/app/assets/images/default_cover_image.jpg")
        filename = "default_cover_image#{user.id}.jpg"

        user.cover_image.attach(io: file, filename: filename)
        user.save
      end
    end
  end
end
