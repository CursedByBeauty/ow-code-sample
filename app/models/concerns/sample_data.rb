class CreateSamples <ActiveRecord::Migration[7.0]
    # ATTEMPTED TO CREATE A TABLE FOR THE COLUMNS SKU TO PART_STATUS
    def change
        create_table :sample_data do |t|
            t.string :sku
            t.string :display_pn
            t.string :be_product_cat_name
            t.text :short_description
            t.integer :lead_time
            t.text :meta_description
            t.string :meta_title
            t.string :part_status


