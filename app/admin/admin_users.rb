ActiveAdmin.register AdminUser do
  permit_params :email, :password, :password_confirmation

  index do
    selectable_column
    id_column
    column :email
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    actions
  end

  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.inputs do
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

  show do
    panel "Admin User Details" do
      attributes_table_for admin_user do
        row :email
        row :created_at
        row :updated_at
        row "Uploaded tracks" do |admin_user|
          link_to "Uploaded tracks!", admin_tracks_path(q: { admin_user_id_eq: admin_user.id })
        end
      end
    end
  end
end
