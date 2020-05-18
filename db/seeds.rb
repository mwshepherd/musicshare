User.create(username: 'admin', fullname: 'Admin', password: 'admin123', email: 'admin@musicshare.com', bio: 'Admin of musicshare.com', is_admin: true)
puts 'Created Admin'

User.create(username: 'testUser', fullname: 'Test User', password: '123456', email: 'test@test.com', bio: 'I am a test user on music share')
User.create(username: 'michaelshepherd', fullname: 'Michael Shepherd', password: '123456', email: 'm@gmail.com', bio: 'A little bio about myself here')
puts 'Created Users'

Category.create(name: 'Bass')
Category.create(name: 'Brass')
Category.create(name: 'Drums & Percussion')
Category.create(name: 'Guitars')
Category.create(name: 'Keyboards')
Category.create(name: 'Microphones')
Category.create(name: 'Rooms')
Category.create(name: 'Strings')
Category.create(name: 'Studio Equipment')
Category.create(name: 'Synthesizers')
Category.create(name: 'Woodwind')
puts 'Created Categories'