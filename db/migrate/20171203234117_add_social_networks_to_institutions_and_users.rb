class AddSocialNetworksToInstitutionsAndUsers < ActiveRecord::Migration
  def change
  	add_column :users, :institution_custom, :boolean, default: false
  	add_column :users, :twitter, :text
  	add_column :users, :facebook, :text
  	add_column :users, :youtube, :text
  	add_column :users, :linkedin, :text 
  	add_column :users, :instagram, :text
  	add_column :institutions, :twitter, :text
  	add_column :institutions, :facebook, :text
  	add_column :institutions, :youtube, :text
  	add_column :institutions, :linkedin, :text 
  	add_column :institutions, :instagram, :text
  end
end
