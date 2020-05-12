# rails_magic
Workshop on Meta-programming and Active Record. If you're interested in learning more Metaprogramming Ruby is an excellent resource https://github.com/dazhizhang/ruby-rails/blob/master/Metaprogramming%20Ruby%2C%202nd%20Edition.pdf 

# Setup

`ruby seeds.rb`

# Problems

### Spend a couple minutes understanding what's already in the Record class

### Add setter and getter methods for columns in the Record class. Rails 1.0 accomplished this by overriding #method_missing. Don't forget that respond_to? should stay accurate.

### Dynamically implementing column methods is relatively slow, so as a performance optimization Rails 2 updated the #method_missing call so that it actually defines static methods for the columns. That way the next time the method is called method_missing isn't needed.

### If you like, implement the dynamic #find_by_x methods as well.

### Before/After callbacks were implemented in early versions of rails by leveraging alias_method to add behavior before and after e.g. #save. Try to implement this.

### Any features you've always wondered about? Take at crack at them now! Ideas: `.validates`, model generators, "Did you mean?" messages for NoMethod errors.
