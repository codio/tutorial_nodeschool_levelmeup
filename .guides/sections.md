---
title: Getting Started
files: []
editable: true
layout: 2-panels-tree

---
##Challenge
To get into the rhythm, let's do a simple *hello world*.

Write a Node program that accepts two command-line arguments, `X` and `Y` and prints out to the console the following text:

    ALL YOUR *X* BELONG TO *Y*

When you have completed your program, you can run it in the test environment with:

    levelmeup run program.js

And once you are happy that it is correct then run:

    levelmeup verify program.js

And your submission will be verified for correctness. After you have a correct solution, run `levelmeup` again and select the next problem!

---
title: Get your level on
files: []
editable: true
layout: ""

---
##Challenge
Write a program that opens a LevelDB data-store using [`level`](https://npmjs.org/package/level).

Fetch and print to the console the value associated with the key 'levelmeup'.

The first command-line argument to your program will be the full path to the directory containing the LevelDB store.

##Hints
[`level`](https://npmjs.org/package/level) is a package that bundles both [`levelup`](https://npmjs.org/package/levelup), the Node-friendly data-store API and [`leveldown`](https://npmjs.org/package/leveldown), the low-level LevelDB binding.

You will need to `npm install level` to get started with this exercise.

You can open an existing data-store, or create a new one, by invoking `level()` and passing in a path to a directory.  The function returns a new *LevelUP* instance.

All LevelUP methods are asynchronous. To `get` a value out of the data-store, use the `.get(key, callback)` method:

    var level = require('level')
    var db = level('/path/to/db/')
    db.get('foo', function (err, value) {
      console.log('foo =', value)
    })

###Documentation
- [level](https://npmjs.org/package/level) module
- [levelup](https://github.com/rvagg/node-levelup)
- [leveldown](https://github.com/rvagg/node-leveldown)
---
title: The basics - Get
files: []
editable: true
layout: ""

---
##Challenge
Write a program that opens a LevelDB data-store using `level`.

The store will contain up to 10 entries with keys in the form:

  key *X*

Where `X` is an integer between 0 and 100.

You must find those entries and print them out to the console, ordered by `X`, ascending. You should print them out with:

    console.log(key + '=' + value)
    // will output "key12=here is that random text"

The full path to the data-store will be provided to your program as the first command-line argument.

##Hints
When you perform a [`.get()`](https://github.com/rvagg/node-levelup#get) operation, if the entry does not exist your callback will receive an error object as the first argument.

It is also possible to receive I/O errors but you can differentiate a `NotFoundError` by checking `err.type == 'NotFoundError'` or by checking for a `err.notFound` boolean.

Using `.get()` is recommended for this exercise but if you're tempted to use a ReadStream to solve this problem, beware that the sorting may be a problem.

###Documentation
- [levelup](https://github.com/rvagg/node-levelup)
- [db.get()](https://github.com/rvagg/node-levelup#get)
- [levelup](https://github.com/rvagg/node-levelup)

---
title: The basics - Put
files: []
editable: true
layout: ""

---
##Challenge
Write a program that opens a LevelDB data-store using `level`.

The full path to the data-store will be provided to your program as the first command-line argument.

The second command-line argument is a string containing a complete JSON-encoded object. Parse this object and `put` each property of the object into your data-store where the property name is the entry's key and the property value is the entry's value.

Your solution will be verified by reading the data-store and checking against the object that was provided to you.

##Hints
The [`put()`](https://github.com/rvagg/node-levelup#put) method in LevelUP is very simple, you just need to supply the key and value. An optional callback may be passed if you need to know when the data has been committed to the store or to properly catch any errors (otherwise errors will be thrown):

    var db = level('/path/to/db/')
    db.put('foo', 'bar', function (err) {
      if (err)
        return console.error('Error in put():', err)
      console.error('put foo = bar')
    })

You may also call [`db.close()`](https://github.com/rvagg/node-levelup#close) after all your callbacks have returned, however this is optional as the data-store will be automatically closed when your program exits. An open LevelDB store will not keep your program running indefinitely.

To get output for debugging when running `levelmeup run program.js` you should use `console.error` instead of `console.log`.

###Documentation
- [levelup](https://github.com/rvagg/node-levelup)
- [`put()`](https://github.com/rvagg/node-levelup#put)
- [`db.close()`](https://github.com/rvagg/node-levelup#close)


---
title: The basics - Batch
files: []
editable: false
layout: ""

---
##Challenge
Write a program that opens a LevelDB data-store using `level`.

The full path to the data-store will be provided to your program as the first command-line argument.

The second command-line argument will be a full path to a file containing some data you must load in to the data-store. Each `line` of the file will contain two or three strings separated by commas. The first string will either be `put` or `del`, the second string will be a `key` and in the case of a `put`, the third string will be a `value`.

For example:

    put,@izs,Isaac Z. Schlueter
    put,@tmpvar,Elijah Insua
    put,@mrbruning,Max Bruning
    del,@darachennis

In this case, you have 3 new entries to add, mapping twitter handles to real names, and one entry to remove.

You are encouraged to use the [`batch()`](https://github.com/rvagg/node-levelup#batch) method for this exercise. A `batch` operation is an atomic, and efficient mechanism for performing multiple writes (put and delete).

##Hints
The `batch()` method has two forms:

 * The [*array form*](https://github.com/rvagg/node-levelup#batch) lets you provide an array containing your operations followed by an optional callback. The array must contain objects of the form:

     { type: 'put', key: 'foo', value: 'bar' }
     or:
     { type: 'del', key: 'foo' }

 * The [*chained form*](https://github.com/rvagg/node-levelup#batch_chained) is closer to the way that LevelDB exposes its batch operation. Calling `batch()` with no arguments returns a `Batch` object that you can use to build your complete set of writes and then submit when ready. It has the following methods:

     - batch.put('key', 'value')
     - batch.del('key')
     - batch.write(callback)

   You can't use the chained form of batch until the LevelUP instance is *"ready"*, you can determine this by either providing a callback to the main `level()` function or by listening to a "ready" event on the resulting LevelUP object. See the LevelUP documentation for more details.

Batch writes are "atomic" in that either all writes succeed or they all fail. If you receive an error on your callback then you can safely assume that your whole batch failed.

The lines in the file can be safely split with:

    var arr = line.split(',')

To get output for debugging when running `levelmeup run program.js` you should use console.error instead of console.log.

###Documentation
- [levelup](https://github.com/rvagg/node-levelup)
- [`batch()` (array form)](https://github.com/rvagg/node-levelup#batch)
- [`batch()` (chained form)](https://github.com/rvagg/node-levelup#batch_chained)
---
title: Streaming
files: []
editable: false
layout: ""

---
##Challenge
Write a program that prints all of the key/value pairs in a LevelDB store to the console. You will be provided with the location of the store as the first argument on the command-line.

Each entry should be printed on a new line to stdout in the form `key=value`

##Hints
Since you don't know what the keys are in this exercise you can't use `get()`. Instead, you'll need to query the data store using a ReadStream.

The [`createReadStream()`](https://github.com/rvagg/node-levelup#createReadStream) method creates a standard Node object-stream where each chunk, or 'data' event, is an entry in the data store. Each data object has both 'key' and 'value' properties for the entry.

You can therefore stream the entire contents of the data store with:

    db.createReadStream().on('data', function (data) {
      // data.key and data.value
    })

Also note that the 'error' event may also be emitted if there is an I/O error.

###Documentation
- [levelup](https://github.com/rvagg/node-levelup)
- [`createReadStream()`](https://github.com/rvagg/node-levelup#createReadStream)
---
title: "@horse js Count"
files: []
editable: false
layout: ""

---
##Challenge
You have been provided with a rich and valuable data-set that you need to provide a simple query interface to.

In this exercise you will be given a LevelDB store that contains over 2,000 tweets from @horse_js. Your job is to query this data-set and return the number of tweets that occur from a given date to the *end* of the data set.

Each entry is a single tweet. The key is the exact time that the tweet was sent, in standard ISO date format (i.e. the format generated by the `Date` object's `toISOString()` method.) The value of the entry is simply a String representing the tweet's content.

Write a **module** (not a program) that exports a single function that accepts three arguments

1. an instance of an existing LevelUP database
1. a date string, of the form YYYY-MM-DD
1. a callback function.

The first argument returned on the callback should be an Error if one occurred or null. The second argument, if there was no error, should be an integer, representing the number of tweets since that date.

Your solution will be checked against the official solution to ensure that your query is targeting the exact range (see details below). The output will include the number of "streamed entries".

##Hints
Use this boilerplate to get started with your module file:

    module.exports = function (db, date, callback) {
      // .. your code here
    }

The ISO date format will always sort lexicographically, which means that our tweets appear in date/time order in our data store without any special work required on your part.

In this exercise, you will need to use the [`createReadStream()`](https://github.com/rvagg/node-levelup#createReadStream) method but you will need to restrict the range of entries to just the data you need, i.e. you must perform a "range query".

By default, the range is the whole store, but you can narrow it down to a start and/or end key. For this exercise you want to start at a particular date and continue to the end of the store.

Some of the power of range queries comes from the fact that your start and end keys need not even exist. If your start key does not exist then the data will start from the entry with a key that would come next in the sorted order.

When you call [`createReadStream()`](https://github.com/rvagg/node-levelup#createReadStream), provide an options object with the property 'start'. The value of this property can simply be the original date string since YYYY-MM-DD is how the ISO format starts and this will make the ReadStream jump to the first key that begins with that prefix, i.e. the first tweet on that day.

    db.createReadStream({ start: '...' })...

The rest of the solution will involve incrementing a counter for each 'data' event you receive and then returning the total count as the second argument on the callback.

###Documentation
- [levelup](https://github.com/rvagg/node-levelup)
- [`createReadStream()`](https://github.com/rvagg/node-levelup#createReadStream)
- [modules](http://nodejs.org/api/modules.html#modules_modules)
---
title: "@horse js Tweets"
files: []
editable: false
layout: ""

---
##Challenge
In this exercise you will be provided with a LevelDB store that contains over 2,000 tweets from *@Horse_js*. Your job is to query this data set for tweets that were made on a particular date.

Each entry is a single tweet. The key is the exact time that the tweet was sent, in standard ISO date format (i.e. the format generated by the Date object's `toISOString()` method.) The value of the entry is simply a String representing the tweet's content.

Write a **module** (not a program) that exports a single function that accepts three arguments: an instance of the levelup database, a date string, of the form YYYY-MM-DD and a callback function.

The first argument to the callback should be an Error if one occurred or null.

The second argument, if there was no error, should be an **array where each element is the String text of a tweet**.

The array should contain ordered tweets for the **single day** given as the first argument to your function. You must not return tweets for any other day.

Your solution will be checked against the official solution to ensure that your query is targeting the exact range (see details below). The output will include the number of "streamed entries".

##Hints
The ISO date format will always sort lexicographically, which means that our tweets appear in date/time order in our data store without any special work on our part.

In this exercise, you will need to use the [`createReadStream()`](https://github.com/rvagg/node-levelup#createReadStream) method but you will need to restrict the range of entries to just the data you need, i.e. you must perform a "range query".

By default the range is the whole store, but you can narrow it down to a start and/or end key. For this exercise you want to start at the first tweet on the given day and end at the last tweet of that day.

Some of the power of range queries comes from the fact that your start and end keys need not even exist. If your start key does not exist then the data will start from the entry with a key that would come next in the sorted order. If your end key does not exist then your query will end at the entry with a key that would come before your end key in sorted order.

To target a range, you supply an options object to [`createReadStream()`](https://github.com/rvagg/node-levelup#createReadStream) with 'start' and/or 'end' properties that define your range keys:

    db.createReadStream({ start: 'bar', end: 'foo' })...

Keep in mind that since your range keys need not exist you only need to supply any prefix of the keys you are looking for, e.g. '2010' will jump to the first key starting with '2010', which might end up matching '2010-09-04T03:51:30.929Z'.

Because the 'end' key of your range will be inclusive, you will need to create a pseudo-key that would match only the keys you want. Consider that if you used a 'start' of '2010' and 'end' of '2011' you would get all entries that start with both '2010' and '2011'. The idiomatic way (but not the only way) to do this with LevelUP is to append '\xff'
to the end of your key, this is the last ASCII charcater. So, 'start' of '2010' and 'end' of '2010\xff' would only match keys starting with '2010'.

###Documentation
- [levelup](https://github.com/rvagg/node-levelup)
- [`createReadStream()`](https://github.com/rvagg/node-levelup#createReadStream)
---
title: Keywise
files: []
editable: false
layout: ""

---
##Challenge
Write a program that reads in a JSON file containing mappings of usernames to their GitHub repositories and store them in a LevelUP data-store such that they can be searched.

Your first command-line argument will be the full path to the LevelUP store where you need to write the data.

You will be given the path to a JSON file as the second command-line argument, you can use `require(process.argv[3])` to load and parse it into a JavaScript object.

The JSON file is an array with two kinds of rows, some are users:

    { "type": "user", "name": "maxogden" }

And some are repositories:

    { "type": "repo", "name": "mux-demux", "user": "dominictarr" }

You must write all of the entries in this file to the data-store.

Open the data-store and write data with '!' as a delimiter such that the verify script will be able to read the **repos for each user** by doing the following range query:

    db.createReadStream({ start: 'rvagg!', end: 'rvagg!~' })

The user data should also be fetchable with:

    db.get('rvagg', function (err, user) { ... })

The value of each entry of the data-store should be the same as the original JSON object from the data file.

##Hints
To simplify the use of JSON here you can open your LevelUP store with the option: [`valueEncoding: 'json'`](https://github.com/rvagg/node-levelup#leveluplocation-options-callback), i.e.

    var db = level(process.argv[2], { valueEncoding: 'json' })

You can then write values as objects directly to the store without having to do a JSON conversion yourself. This also means that read operations will receive a recomposed object.

To get output for debugging when running `levelmeup run program.js` you should use `console.error` instead of `console.log`.

###Documentation
- [levelup](https://github.com/rvagg/node-levelup)
- [`createReadStream()`](https://github.com/rvagg/node-levelup#createReadStream)
- [encoding](https://github.com/rvagg/node-levelup#leveluplocation-options-callback)
---
title: Short Scrabble Words
files: []
editable: false
layout: ""

---
##Challenge
Write a module that stores valid 2, 3 and 4 character Scrabble words and is able to retrieve them according to basic prefix-queries.

Your module should export an `init()` function that accepts 3 arguments

1. a LevelUP `db` object for an empty database
1. an array of 2, 3 and 4 character Scrabble words
1. a callback that you must call once you have finished initialising the database

Your module should also export a `query()` method that also accepts 3 arguments: a LevelUP `db` object (the same store that you initialised with `init()`), a `word` string containing the query, and a callback that you must call with two arguments. The first argument should be null, or an error object if one occurred. The second argument should be an array of all the words in the database which match the query.

Here is a boilerplate module that you can extend for your solution:

    module.exports.init = function (db, words, callback) {
      // insert each word in the words array here
      // then call `callback()` when you are done inserting words
    }

    module.exports.query = function (db, word, callback) {
      // `word` may have '*' chars to denote single-letter wildcards
      // call callback(err, results) with an array of matching words
    }

The `word` query may be a complete word, e.g. 'RUN', or a prefix of a word with `*` characters filling in the blanks, e.g. `RU*` or `R**`.

The `.length` will tell you how long the word should be, your results should only include words of that length. The `*` characters are wild-cards that can match any character.

For simplicity, the wild-cards will only be on the **end** of a query. You will always be given either a complete word or a word prefix. You must limit your results to words of the same length and with the same prefix.

Your solution will be tested against the official solution, you must use a ReadStream that **only** returns the exact words that your query needs to match, and no more.

##Hints
This exercise is about coming up with a key schema that is going to be useful for retrieving results according to the queries you can expect. You will need to come up with a key structure that will let you limit your search to only words of the correct number of characters without including words that have a different number of characters.

Your `init()` function should translate words into appropriate keys, and your `query()` function should be able to translate a query into a `start` and `end` for your ReadStream.

###Documentation
- [levelup](https://github.com/rvagg/node-levelup)
- [`createReadStream()`](https://github.com/rvagg/node-levelup#createReadStream)
- [`batch()` (array form)](https://github.com/rvagg/node-levelup#batch)
- [`batch()` (chained form)](https://github.com/rvagg/node-levelup#batch_chained)

---
title: Sublevel
files: []
editable: false
layout: ""

---
##Challenge
Sometimes you just need a clean namespace to fill up with junk without worrying about conflicting with existing keys in use.

You can use [`sublevel`](https://npmjs.org/package/level-sublevel) for creating clean namespaces!

You can extend a db handle to use sublevel by doing:

    var db = sub(level(...))

Then you can call [`db.sublevel()`](https://npmjs.org/package/level-sublevel) to make a new sublevel.

Just call `db.sublevel()` with a name and you get an object that acts just like a normal db handle except it lives in a namespace:

    var wizards = db.sublevel('wizards')

To level up on this adventure, you will get a database path as the first command-line argument. Create 2 sublevels, one called "robots" and the other called "dinosaurs".

For each sublevel, create a key called "slogan". Set the `slogan` for the dinosaurs sublevel to `'rawr'` and set the `slogan` for the robots sublevel to `'beep boop'`.

##Hints
You will need to `npm install level-sublevel` to get started with this
exercise.

###Documentation
- [levelup](https://github.com/rvagg/node-levelup)
- [`db.sublevel()`](https://npmjs.org/package/level-sublevel)
---
title: Multilevel
files: []
editable: false
layout: ""

---
##Challenge
Write a program that uses [`multilevel`](https://npmjs.org/package/multilevel) to fetch a value from a server running on your computer.

Create a TCP connection with the core [`net`](http://nodejs.org/api/net.html#net_net) module to port **4545** on localhost. Pipe this connection through a multilevel RPC stream and back to the connection. Your code should look like:

    var db = multilevel.client()
    var connection = net.connect(4545)
    connection.pipe(db.createRpcStream()).pipe(connection)

You will then have a `db` object that you can interact with like a [LevelUP](https://github.com/rvagg/node-levelup) object.

Fetch the value from the data store with the key 'multilevelmeup' and print it to the console.

**You must close the connection after you have fetched the value**

    connection.end()

##Hints
You will need to `npm install multilevel` to get started with this exercise.

###Documentation
- [multilevel](https://npmjs.org/package/multilevel) module
- [net](http://nodejs.org/api/net.html#net_net) module