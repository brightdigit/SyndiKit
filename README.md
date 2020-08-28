&nbsp;

<a href="https://orchardnest.com"><img src="Public/images/logo.svg" height="100px">&nbsp;&nbsp;<img src="Public/images/wordmark.svg" height="75px"></a>



# Swift Articles and News at _[orchardnest.com](https://orchardnest.com)_

[![SwiftPM](https://img.shields.io/badge/SPM-Linux%20%7C%20iOS%20%7C%20macOS%20%7C%20watchOS%20%7C%20tvOS-success?logo=swift)](https://swift.org)
[![Twitter](https://img.shields.io/badge/twitter-@leogdion-blue.svg?style=flat)](http://twitter.com/leogdion)
![GitHub](https://img.shields.io/github/license/brightdigit/OrchardNest)
![GitHub issues](https://img.shields.io/github/issues/brightdigit/OrchardNest)

[![macOS](https://github.com/brightdigit/OrchardNest/workflows/macOS/badge.svg)](https://github.com/brightdigit/OrchardNest/actions?query=workflow%3AmacOS)
[![ubuntu](https://github.com/brightdigit/OrchardNest/workflows/ubuntu/badge.svg)](https://github.com/brightdigit/OrchardNest/actions?query=workflow%3Aubuntu)
[![arm](https://github.com/brightdigit/OrchardNest/workflows/arm/badge.svg)](https://github.com/brightdigit/OrchardNest/actions?query=workflow%3Aarm)
[![Travis (.com)](https://img.shields.io/travis/com/brightdigit/OrchardNest?logo=travis)](https://travis-ci.com/brightdigit/OrchardNest)

[![Codecov](https://img.shields.io/codecov/c/github/brightdigit/OrchardNest)](https://codecov.io/gh/brightdigit/OrchardNest)
[![CodeFactor Grade](https://img.shields.io/codefactor/grade/github/brightdigit/OrchardNest)](https://www.codefactor.io/repository/github/brightdigit/OrchardNest)
[![codebeat badge](https://codebeat.co/badges/4f86fb90-f8de-40c5-ab63-e6069cde5002)](https://codebeat.co/projects/github-com-brightdigit-OrchardNest-master)
[![Code Climate maintainability](https://img.shields.io/codeclimate/maintainability/brightdigit/OrchardNest)](https://codeclimate.com/github/brightdigit/OrchardNest)
[![Code Climate technical debt](https://img.shields.io/codeclimate/tech-debt/brightdigit/OrchardNest?label=debt)](https://codeclimate.com/github/brightdigit/OrchardNest)
[![Code Climate issues](https://img.shields.io/codeclimate/issues/brightdigit/OrchardNest)](https://codeclimate.com/github/brightdigit/OrchardNest)
[![Reviewed by Hound](https://img.shields.io/badge/Reviewed_by-Hound-8E64B0.svg)](https://houndci.com)

## 🧐 About <a name = "about"></a>

**OrchardNest is a site built by Leo Dion and dedicated to the Swift and Apple Developer community by providing a source for news, tutorials, podcasts, YouTube videos, and other updates.**

**Based on the wonderful [iOS Dev Directory by Dave Verwer](https://iosdevdirectory.com)**, this aggreates, filters, curates the variety of RSS feeds availables from developers, designers, podcasters, youtubers and newsletters. 

## 🏁 Getting Started <a name = "getting_started"></a>
Here's how to get the server up and running...

### Prerequisites
What things you need to install the software and how to install them.

#### PostgreSQL Server 12.2
Either via server install or docker. 

```
docker run --rm  --name orchardnest-pg -e POSTGRES_HOST_AUTH_METHOD=trust -d -p 5432:5432
```

Create the database by running the `create_db.sql` script:

```
psql -h localhost -U postgres < create_db.sql
```

#### Swift 5.2 

For details on installing Swift 5.2, check out [the instructions from swift.org.](https://swift.org/getting-started/)

<!--
### Installing
A step by step series of examples that tell you how to get a development env running.

Say what the step will be

```
Give the example
```

And repeat

```
until finished
```

End with an example of getting some data out of the system or using it for a little demo.

## 🔧 Running the tests <a name = "tests"></a>
Explain how to run the automated tests for this system.

### Break down into end to end tests
Explain what these tests test and why

```
Give an example
```

### And coding style tests
Explain what these tests test and why

```
Give an example
```
--->

##  Configuration

These are required environment variables used by **OrchardNest**:

### `DATABASE_URL`

Connection URL to the PostgreSQL database.

### `YOUTUBE_API_KEY`

YouTube API Key used for getting YouTube metadata.

## 🎈 Usage <a name="usage"></a>

To run the server simply run:

### Running the Server

```
orchardnestd serve 
```

### Running the Scheduled Jobs

```
orchardnestd queues --scheduled
```

## 🚀 Deployment <a name = "deployment"></a>

Here's the current deployment setup for **OrchardNest**:

* **Linode** for hosting on a ...
* With **Ubuntu 20.04.1** installed, along with
* Using **PostgreSQL Server 12.2** for the database
* **nginx 1.18.0** for the http server
* **supervisord 4.1.0** for managing processes
* **Cloudflare** for help with caching and serving content

Futher details on the server configuration files can be found in [the Configuration directory](Configuration).

## ⛏️ Built Using <a name = "built_using"></a>

* [Server-Side Swift with Vapor 4](https://vapor.codes)
* PostgreSQL Database with Fluent for Vapor
* [Job Queue via Vapor Queues Fluent Driver](https://github.com/m-barthelemy/vapor-queues-fluent-driver) by [Matthieu Barthélemy](https://github.com/m-barthelemy)
* [Plot by John Sundell](https://github.com/johnsundell/plot) for HTML Rendering
* [Ink by John Sundell](https://github.com/JohnSundell/Ink) for Markdown Parsing
* [Milligram for CSS](https://milligram.io) 
* [Elusive Icons for Icons](http://elusiveicons.com)

## ✍️ Authors <a name = "authors"></a>
- [@leogdion](https://github.com/leogdion) - Idea & Initial work

## 🎉 Acknowledgements <a name = "acknowledgement"></a>
Thank you to...

- [Dave Verwer](https://github.com/daveverwer/) for [iOS Dev Weekly](https://iosdevweekly.com), [Swift Package Index](https://swiftpackageindex.com), but most importantly the **(iOS Dev Directory,)[https://iosdevdirectory.com]** which OrchardNest uses to gather content from the community
- [John Sundell](https://github.com/JohnSundell) for Publish but also the components **OrchardNest** uses [Ink](https://github.com/JohnSundell/Ink) and [Plot](https://github.com/JohnSundell/Plot) for helping render our beautiful web site
- **[The Vapor team](https://github.com/vapor)** for making a solid server-side framework for Swift developers
- **[Linode](https://www.linode.com/?r=97e09acbd5d304d87dadef749491d245e71c74e7)** for hosting this great site
