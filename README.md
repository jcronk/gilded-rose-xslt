# Gilded Rose: XSLT version 

As a fun and interesting exercise, I decided to translate the Gilded Rose kata into XSLT.  The source for what I'm doing is almost completely Emily Bache's [multi-language repository of Gilded Rose versions](https://github.com/emilybache/GildedRose-Refactoring-Kata).  From her original README:

> This Kata was originally created by Terry Hughes (http://twitter.com/#!/TerryHughes). It is already on GitHub [here](https://github.com/NotMyself/GildedRose). See also [Bobby Johnson's description of the kata](http://iamnotmyself.com/2011/02/13/refactor-this-the-gilded-rose-kata/).
> 
> I translated the original C# into a few other languages, (with a little help from my friends!), and slightly changed the starting position. This means I've actually done a small amount of refactoring already compared with the original form of the kata, and made it easier to get going with writing tests by giving you one failing unit test to start with. I also added test fixtures for Text-Based approval testing with TextTest (see [the TextTests](https://github.com/emilybache/GildedRose-Refactoring-Kata/tree/master/texttests))
> 
> As Bobby Johnson points out in his article ["Why Most Solutions to Gilded Rose Miss The Bigger Picture"](http://iamnotmyself.com/2012/12/07/why-most-solutions-to-gilded-rose-miss-the-bigger-picture), it'll actually give you
> better practice at handling a legacy code situation if you do this Kata in the original C#. However, I think this kata
> is also really useful for practicing writing good tests using different frameworks and approaches, and the small changes I've made help with that. I think it's also interesting to compare what the refactored code and tests look like in different programming languages.

I want to note that as a legacy code refactoring exercise for my purposes, translating it into XSLT is good, because at my company there is a ton of XSLT legacy code and this will make a good training tool.  

I also want to note that this is a brilliant exercise and Terry Hughes is very observant and insightful to have come up with something that not only is a small (but still out of control) example of bad legacy code, but also to have written requirements that give you a clear story about how the code got to look the way it does.  This will be familiar to a lot of people, I think.  

## Requirements (taken from the original)

Hi and welcome to team Gilded Rose. As you know, we are a small inn with a prime location in a
prominent city ran by a friendly innkeeper named Allison. We also buy and sell only the finest goods.
Unfortunately, our goods are constantly degrading in quality as they approach their sell by date. We
have a system in place that updates our inventory for us. It was developed by a no-nonsense type named
Leeroy, who has moved on to new adventures. Your task is to add the new feature to our system so that
we can begin selling a new category of items. First an introduction to our system:

- All items have a SellIn value which denotes the number of days we have to sell the item
- All items have a Quality value which denotes how valuable the item is
- At the end of each day our system lowers both values for every item

Pretty simple, right? Well this is where it gets interesting:

- Once the sell by date has passed, Quality degrades twice as fast
- The Quality of an item is never negative
- "Aged Brie" actually increases in Quality the older it gets
- The Quality of an item is never more than 50
- "Sulfuras", being a legendary item, never has to be sold or decreases in Quality
- "Backstage passes", like aged brie, increases in Quality as its SellIn value approaches; Quality increases by 2 when there are 10 days or less and by 3 when there are 5 days or less but Quality drops to 0 after the concert

We have recently signed a supplier of conjured items. This requires an update to our system:

- "Conjured" items degrade in Quality twice as fast as normal items

Feel free to make any changes to the UpdateQuality method and add any new code as long as everything
still works correctly. However, do not alter the Item class or Items property as those belong to the
goblin in the corner who will insta-rage and one-shot you as he doesn't believe in shared code
ownership (you can make the UpdateQuality method and Items property static if you like, we'll cover
for you).

Just for clarification, an item can never have its Quality increase above 50, however "Sulfuras" is a
legendary item and as such its Quality is 80 and it never alters.

## Testing

The usual way to do this is to use golden copy testing.  When I converted this, I used Emily Bache's original texttest fixture and wrote a stylesheet to convert my output into hers, then ran a shell script to run the transformation for each day, convert the XML output to the texttest format, and then compare.  For my purposes, I'm expecting XML output already, and so as long as I can be sure this is correct to their original requirements, the XML output will work fine as the golden copy.  

Since this is legacy code that we're supposed to make changes to, the golden copy tests define *existing* behavior, not the desired behavior.  These are to make sure that you don't break anything when you refactor it.  

## XSLT-Specific Notes

This is fundamentally a data translation problem if you look at it in XSLT terms.  You will have an input file with `<Item>` rows that have all the attributes of the Item class in the original, and your output will be (correctly) updated `<Item>` elements.  
