ActiveAdmin.register Track do
  permit_params :title, :audio, :admin_user_id

  controller do
    def create
      params[:track].merge!(admin_user_id: current_admin_user.id)
      create!
    end
  end

  form(:html => { :multipart => true }) do |f|
    # byebug
    f.semantic_errors *f.object.errors.keys
    f.inputs "Track" do
      f.input :title
      f.file_field :audio, as: :file
    end
    f.actions
  end

  index do
    selectable_column
    column :id
    column :title
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

end
