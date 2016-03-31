# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Activity.create(description: 'Exercise ', value: 1, needsquantity: true);
Activity.create(description: 'Participate in a biometric screening and a Health Risk Assessment', value: 25);
Activity.create(description: 'Attend 6 sessions with the Nurse for smoking cessation', value: 25);
Activity.create(description: 'Complete any LifeCare Alliance wellness program', value: 25);
Activity.create(description: 'Share a success story in the wellness newsletter', value: 10);
Activity.create(description: 'Attend a 30 minute wellness program', value: 10);
Activity.create(description: 'One month of using the lactation rooms ', value: 10);
Activity.create(description: 'Volunteer for a Meal route', value: 10);
Activity.create(description: 'An appointment with the Nurse or Dietitian ', value: 5);
Activity.create(description: 'Wellness checkup or immunization ', value: 5);
Activity.create(description: 'Check your blood glucose, blood pressure, or weight', value: 2);
Activity.create(description: 'Track your steps with a pedometer for one day', value: 2);
Activity.create(description: 'Drink at least 8 cups of water daily', value: 2);
Activity.create(description: 'For one day, drink only healthy beverages such as water, plain coffee, or plain tea', value: 2);
Activity.create(description: 'Eat 5 or more servings of fruits and vegetables in a day', value: 2);
Activity.create(description: 'Bring your lunch to work from home', value: 2);
Activity.create(description: 'Use a food tracker like MyFitnessPal for one day', value: 2);
Activity.create(description: 'Try a new healthy recipe', value: 2);
Activity.create(description: 'Get at least 7 hours of sleep', value: 2);
Activity.create(description: 'When stressed, close your eyes and take 10 slow, deep breaths or visualize your favorite place for 30 seconds', value: 2);

#Department.create(dept_name: 'Carrie\'s and Catering');
#Department.create(dept_name: 'Dining Centers');
#Department.create(dept_name: 'Help at Home');
#Department.create(dept_name: 'Home Delivered');
#Department.create(dept_name: 'IMPACT and CCC');
#Department.create(dept_name: 'Kitchen');
#Department.create(dept_name: 'Management and Grants');
#Department.create(dept_name: 'Wellness');



admin = User.create(fname: "admin", lname: "admin", department: "admin", email: 'wellnessadmin@lifecarealliance.org', password: "dontforget", password_confirmation: "dontforget"); #password: dontforget
admin.toggle!(:admin)
