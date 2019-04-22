
ActiveAdmin.register Track do
  permit_params :title, :audio, :admin_user_id, :tag_ids
  filter :admin_user, :collection => proc {(AdminUser.all).map{|c| [c.email, c.id]}}
  filter :title
  filter :tags, as: :select, multiple: true
  filter :created_at
  filter :updated_at


  controller do
    def create
      params[:track].merge!(admin_user_id: current_admin_user.id)
      create!
    end

    def update
      params[:track].merge!(admin_user_id: current_admin_user.id)
      update!
    end
  end

  form(:html => { :multipart => true }) do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs "Track" do
      f.input :title
      f.file_field :audio, as: :file
      f.input :tags
    end
    f.actions
  end

  index do
    selectable_column
    column :id
    column :title
    column :admin_user
    column :created_at
    column :updated_at
    column 'Audio' do |track|
      span do
        "<audio controls>
          <source src='#{track.audio.url}' type='audio/mp3'>
          Your browser does not support the audio element.
        </audio>".html_safe
      end
    end
    actions
  end

  show do
    attributes_table do
      row :title
      row 'Uploader' do |t|
        t.admin_user
      end
      row 'Audio File' do |t|
        span do
          "<audio controls>
            <source src='#{t.audio.url}' type='audio/mp3'>
            Your browser does not support the audio element.
          </audio>".html_safe
        end
      end
      row :created_at
      row :updated_at
      row :tag
    end
  end
end
