from django.contrib import admin
from .models import Author, Genre, Book, BookInstance, Language

# admin.site.register(Author)
admin.site.register(Genre)
# admin.site.register(Book)
# admin.site.register(BookInstance)
admin.site.register(Language)


# Define the Admin class for Author
class AuthorAdmin(admin.ModelAdmin):
  list_display = ('last_name', 'first_name', 'date_of_birth', 'date_of_death')

# Register the Admin class for Author with the associated model
admin.site.register(Author, AuthorAdmin)


# Register the Admin class for Book using the decorator
@admin.register(Book)
class BookAdmin(admin.ModelAdmin):
  list_display = ('title', 'author', 'display_genre')

# Register the Admin class for BookInstance using the decorator
@admin.register(BookInstance)
class BookInstanceAdmin(admin.ModelAdmin):
  list_display = ('__str__', 'status', 'due_back')
  list_filter = ('status', 'due_back')
