# EPiServer Commerce Integration Test Sample

This project is intended to be something you can base your projects integration tests on. It will set up a database for EPiServer CMS as well as EPiServer commerce and all necessary dependencies so that you can focus on writing tests.

## Requirements
In order to run these tests you need the following:

 * The user running the tests also need to be an admin on the SQL server to be able to create the databases.

## Usage
Any new tests must inherit from the EPiCommerce.Integration.Sample.TestSupport.TestBase class as can be seen from the included example spec.

```
using EPiCommerce.Integration.Sample.TestSupport;

public class When_saving_a_new_entry_under_a_catalog : TestBase
{
    //code here
}
```

## Initialization
Most magic regarding initializing a site in an EPiServer Commerce context is done in the OnAssemblyStart method in the EPiCommerce.Integration.Sample.TestSupport.AssemblyContext class. That will be run once when running tests and keep the initialized state during all tests. There are some known issues with Commerce specifically that is being addressed with the ReInitializeCommerceInitializationModule method in the EPiCommerce.Integration.Sample.TestSupport.TestBase class.

