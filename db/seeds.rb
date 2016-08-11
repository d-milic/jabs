# This file should contain all the record creation needed
# to seed the database with its default values.
# The data can then be loaded with the rake db:seed
# (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create([
              {
                username: 'user1',
                email: 'user1@mail.com',
                first_name: 'john', last_name: 'doe',
                password: 'password1', password_confirmation: 'password1'
              },
              {
                username: 'user2',
                email: 'user2@mail.com',
                first_name: 'jane', last_name: 'doe',
                password: 'password2', password_confirmation: 'password2'
              }
            ])
categories = Category.create([
                               { name: 'Art' },
                               { name: 'Education' },
                               { name: 'Entertainment' },
                               { name: 'Lifestyle' },
                               { name: 'Sports' },
                               { name: 'Technology' }
                             ])

Category.create([
                  { name: 'Painting', parent_category_id: categories.first.id },
                  { name: 'Sculpting', parent_category_id: categories.first.id },
                  { name: 'Music', parent_category_id: categories.first.id }
                ])
