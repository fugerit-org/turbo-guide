# disable sleep on ubuntu

*Abstract* : 
After updating from ubuntu 20 to ubuntu 22 one virtual machine on a cloud provider, the sleep mode was automatically activated. 
(pretty annoying the server was going asleep every six minutes of idle).

[Found this interesting guide](https://en-wiki.ikoula.com/en/Disable_Ubuntu_sleep_mode)

*Quickstart* :

Disable sleep : `sudo systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target`

Check status : `sudo systemctl status sleep.target` 
(you should see it masked Loaded: masked (Reason: Unit sleep.target is masked.))