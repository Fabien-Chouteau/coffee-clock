# coffee-clock
Waking up with a fresh cup of coffee

A few weeks ago one of my colleagues shared this kickstarter project : [The
Barisieur](https://www.kickstarter.com/projects/393281213/the-barisieur-designer-coffee-and-tea-alarm-clock).
It's an alarm clock coffee maker, promising to wake you up with a freshly
brewed cup of coffee every morning. I jokingly said "just give me an espresso
machine and I can do the same". Soon after, the coffee machine is in my office.
Now it is time to deliver :)

The basic idea is to control the espresso machine from an STM32F469 board and
use the beautiful screen to display the clock face and configuration interface.

##  Build instructions

- Make sure to get all the Git submodules:

    ```shell
    $ git submodule init
    $ git submodule update --recursive
    ```

- Download and install the [GNAT for ARM package](http://libre.adacore.com/download/configurations)
- Start GNAT Programing Studio
- Open the project file `coffee_clock_stm32f469.gpr`
- Use the "Build all" button to compile
