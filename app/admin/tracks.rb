
ActiveAdmin.register Track do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end
  permit_params :title, :audio

  form(:html => { :multipart => true }) do |f|
    # byebug
    f.semantic_errors *f.object.errors.keys
    f.object.admin_user_id = 1
    puts f.object.inspect
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
