# Rails web app to search for Financial Times headlines  

https://headline-search.herokuapp.com/  
(works locally, deployed version is faulty, attempting to fix)

(Remember, you still need to have an FT account to read the articles.)

## MVP requirement:  

Build a server-rendered site that displays an article from the Financial  
Times. You may use FT's Developer APIs to achieve this.  

Provide a search box for users to search for headlines containing specific  
words (i.e. searching for 'brexit' should return a list of brexit-related  
headlines).

## Optional extras:

- deployed on Heroku
- has a similar look (background colour and font) as ft.com

## Construction:

- "rails new headline-search --skip-active-record"  
- install bootstrap and excon gems (for calling APIs and styling, respectively)  
- create HeadlineController file in app/controllers  

## Improvements if more time:

- clean up code and create a model (for separation of concerns)
- write tests
- use CSS not HTML

-------------------------------------------------------------------------------

Troubleshooting if 'rails s' fails after shutting down IDE and  
starting again:

- attempt rails s, and when it doesn't work, uninstall the uncooperative gems  
and reinstall again, individually (e.g. gem uninstall puma...  
then gem install puma)
