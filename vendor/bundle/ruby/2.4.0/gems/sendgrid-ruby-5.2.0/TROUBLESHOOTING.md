If you have a non-library SendGrid issue, please contact our [support team](https://support.sendgrid.com).

If you can't find a solution below, please open an [issue](https://github.com/sendgrid/sendgrid-ruby/issues).


## Table of Contents

* [Migrating from v2 to v3](#migrating)
* [Continue Using v2](#v2)
* [Testing v3 /mail/send Calls Directly](#testing)
* [Error Messages](#error)
* [Versions](#versions)
* [Environment Variables and Your SendGrid API Key](#environment)
* [Using the Package Manager](#package-manager)
* [Rails Specifics](#rails-specifics)
* [Viewing the Request Body](#request-body)

<a name="migrating"></a>
## Migrating from v2 to v3

Please review [our guide](https://sendgrid.com/docs/Classroom/Send/v3_Mail_Send/how_to_migrate_from_v2_to_v3_mail_send.html) on how to migrate from v2 to v3.

<a name="v2"></a>
## Continue Using v2

[Here](https://github.com/sendgrid/sendgrid-ruby/tree/0fbf579c0f7ed1dff87adc4957c4dc5a6b257068) is the last working version with v2 support.

Using rubygems:

Add this line to your application's Gemfile:

```bash
gem 'sendgrid-ruby',  '1.1.6'
```

And then execute:

```bash
bundle
```

Or install it yourself using:

```bash
gem install sendgrid-ruby -v 1.1.6
```

Download:

Click the "Clone or download" green button in [GitHub](https://github.com/sendgrid/sendgrid-ruby/tree/0fbf579c0f7ed1dff87adc4957c4dc5a6b257068) and choose download.

<a name="testing"></a>
## Testing v3 /mail/send Calls Directly

[Here](https://sendgrid.com/docs/Classroom/Send/v3_Mail_Send/curl_examples.html) are some cURL examples for common use cases.

<a name="error"></a>
## Error Messages

To read the error message returned by SendGrid's API:

```ruby
begin
    response = sg.client.mail._("send").post(request_body: mail.to_json)
rescue Exception => e
    puts e.message
end
```

<a name="versions"></a>
## Versions

We follow the MAJOR.MINOR.PATCH versioning scheme as described by [SemVer.org](http://semver.org). Therefore, we recommend that you always pin (or vendor) the particular version you are working with to your code and never auto-update to the latest version. Especially when there is a MAJOR point release, since that is guaranteed to be a breaking change. Changes are documented in the [CHANGELOG](https://github.com/sendgrid/sendgrid-ruby/blob/master/CHANGELOG.md) and [releases](https://github.com/sendgrid/sendgrid-ruby/releases) section.

<a name="environment"></a>
## Environment Variables and Your SendGrid API Key

All of our examples assume you are using [environment variables](https://github.com/sendgrid/sendgrid-ruby#setup-environment-variables) to hold your SendGrid API key.

If you choose to add your SendGrid API key directly (not recommended):

`sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])`

becomes

`sg = SendGrid::API.new(api_key: 'SENDGRID_API_KEY')`

In the first case SENDGRID_API_KEY is in reference to the name of the environment variable, while the second case references the actual SendGrid API Key.

<a name="package-manager"></a>
## Using the Package Manager

We upload this library to [RubyGems](https://rubygems.org/gems/sendgrid-ruby) whenever we make a release. This allows you to use [RubyGems](https://rubygems.org) for easy installation.

In most cases we recommend you download the latest version of the library, but if you need a different version, please use:

Add this line to your application's Gemfile:

```bash
gem 'sendgrid-ruby',  'X.X.X'
```

And then execute:

```bash
bundle
```

Or install it yourself using:

```bash
gem install sendgrid-ruby -v X.X.X
```

<a name="rails-specifics"></a>
## Rails Specifics

- Namespace collision between Rails own `Mail` class and sendgrid class `Mail`. To avoid that issues please use `SendGrid::Mail` instead.

- Possibility of a namespace collision between the sendgrid class `Email` and your own defined `Email` class. To avoid these issues, you can skip the `include SendGrid` line and use the `SendGrid::` prefix for Email. Please see this [SO answer](https://stackoverflow.com/questions/41508464/rails-model-name-conflict-with-included-gem?noredirect=1#comment70223099_41508464) for specifics.

<a name="request-body"></a>
## Viewing the Request Body

When debugging or testing, it may be useful to examine the raw request header to compare against the [documented format](https://sendgrid.com/docs/API_Reference/api_v3.html).

You can do this before `response = sg.client.mail._('send').post(request_body: mail.to_json)` like so:

```ruby
puts mail
```
