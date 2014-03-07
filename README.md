# EPiServer Commerce Integration Test Sample

This project is intended to be something you can base your projects integration tests on. It will set up a database for EPiServer CMS as well as EPiServer commerce and all necessary dependencies so that you can focus on writing tests.

This project is using [Machine Specifications](https://github.com/machine/machine.specifications) to setup the tests and [Fluent Assertions](https://github.com/dennisdoomen/FluentAssertions) to assert.

In order to run the tests you can use the runtests.bat file in the root of the project.

## Requirements
In order to run these tests you need the following:

 * A local SQL instance with Full Text Search enabled. Full Text Search is required by EPiServer Commerce. The user running the tests also need to be an admin on the SQL server to be able to create the databases. You also need a SQL server version that can handle [snapshots](http://technet.microsoft.com/en-us/library/ms175158.aspx) as these tests are relying on snapshots to restore the database between tests.
 * An EPiServer license in the project root. Download one from [EPiServer License center](https://license.episerver.com/).

## Usage
Any new specs must inherit from the EPiCommerce.Integration.Sample.TestSupport.TestBase class as can be seen from the included example spec.

```
using EPiCommerceIntegration.TestSupport;

public class When_saving_a_new_entry_under_a_catalog : TestBase
{
    //code here
}
```

## Initialization
Most magic regarding initializing a site in an EPiServer Commerce context is done in the OnAssemblyStart method in the EPiCommerce.Integration.Sample.TestSupport.AssemblyContext class. That will be run once when running tests and keep the initialized state during all tests. There are some known issues with Commerce specifically that is being addressed with the ReInitializeCommerceInitializationModule method in the EPiCommerce.Integration.Sample.TestSupport.TestBase class.

