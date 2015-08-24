# Dinner's Ready 

[![Stories in Ready](https://badge.waffle.io/applegrain/dinners_ready.svg?label=ready&title=Ready)](http://waffle.io/applegrain/dinners_ready) [![Code Climate](https://codeclimate.com/github/applegrain/dinners_ready/badges/gpa.svg)](https://codeclimate.com/github/applegrain/dinners_ready) [![Build Status](https://travis-ci.org/applegrain/dinners_ready.svg)](https://travis-ci.org/applegrain/dinners_ready) [![Test Coverage](https://codeclimate.com/github/applegrain/dinners_ready/badges/coverage.svg)](https://codeclimate.com/github/applegrain/dinners_ready/coverage)

##### [Jai Misra](https://github.com/mrjaimisra), [Mike Reeves](https://github.com/michael-reeves), [Michael Merrell](https://github.com/michaelkm), [Tyler Graham](https://github.com/tgraham777)

The Pivot is the first project for Module 3 at the [Turing School](http://turing.io).
Groups inherited a code base for an online store, and need modify the code for a new purpose.
In our case, we inherited a meals-on-wheels style restaurant, which we need to transform into a website selling photography. 

### Instructions 
- run `git clone git@github.com:mrjaimisra/the_pivot.git`
- run `rails s`, access `http://localhost:3000` in your browser 
- to run the tests, run `bundle exec rspec`  

[Project Outline](https://github.com/turingschool/curriculum/blob/master/source/projects/little_shop.markdown) | [Heroku](https://dinners-ready.herokuapp.com/)

### Areas of focus
- Use TDD to drive all layers of Rails development including unit, integration, and user acceptance tests
- Design a system of models which use one-to-one, one-to-many, and many-to-many relationships
- Practice mixing HTML, CSS, and Rails templates to create an inviting and usable User Interface
- Differentiate responsibilities between components of the Rails stack
- Build a logical user-flow that moves across multiple controllers and models
- Practice an agile workflow and improve communication skills working within a team

### Team workflow 
- **Tools** 
  - [waffle](https://waffle.io/mrjaimisra/the_pivot) 
  - [travis]  (https://travis-ci.org/mrjaimisra/the_pivot)
  - simple cov
   
- **Workflow**
  - checkout a branch named after the waffle story and include the number 
    - example: `2-admin-can-create-meals`
  - use Rubocop locally 
  - Squash and order commits by specs 
  - Push branch and tag with [WIP] until story is completed 
  - Notify group members on Slack when PR is ready for code review 
    - *Aim to* have the PR reviewed within 45 minutes of submission 
    - Fix eventual Hound errors before merging the PR 
  - The group member that merges the PR should 
    - delete the branch on GitHub 
    - close the waffle issue on GitHub 
    - notify the group members on Slack to pull from master 
