Paint
=====

Internal CSS Framework

Contributing
------------
Clone the repository.  Then, run:

    cd paint
    git branch master origin/master
    git flow init -d
    git flow feature start <your feature>

Then, do work and commit your changes.

    git flow feature publish <your feature>

When done, open a pull request to your feature branch.

Releasing
---------

Once the feature branch is merged in develop, create a release branch named after the new version.

    git flow release start 0.0.x
    
Bump the version in the bower.json file.
Commit your changes

    git flow release publish 0.0.x
    
Open a PR to your release branch.
