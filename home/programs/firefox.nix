{ config, lib, pkgs, ... }:

{
  programs.firefox = {
    enable = true;
    policies = {
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      DisablePocket = true;
      PasswordManagerEnabled = false;
      EnableTrackingProtection = {
        Value = true;
        Cryptomining = true;
        Fingerprinting = true;
      };
      FirefoxHome = {
        SponsoredTopSites = false;
        SponsoredPocket = false;
      };
      OverrideFirstRunPage = "";
      Search = {
        Default = "Google";
      };
    };
    profiles.default = { };
  };
}
