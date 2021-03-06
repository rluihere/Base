class base::users {
    group { 'rcsbot':
            ensure          => present,
            gid   => 501,
    }

    group { 'lakassa':
            ensure          => present,
            gid   => 1914,
    }

    group { 'astarov':
            ensure          => present,
            gid           => 1916,
    }

    group { 'tslankard':
            ensure          => present,
            gid           => 1917,
    }


    user { 'rcsbot':
            ensure    => present,
            uid   => 501,
            gid   => 'rcsbot',
            password  => '$6$Z2O1Ldh6$mMRRO09/Uy6Wrl2w25zGdh.hCXJ.Ea0c5QkWgThWNaCiDZ0Magn9Uk.VF1ThCD7HbhbotJvBlkhp2dxBEddSq/',
            comment   => '$hostname rcsbot',
            groups    => ["rcsbot","wheel"],
            require   => Package['ruby-shadow'],
            managehome  => true,
    }


    user { 'lakassa':
            ensure    => present,
            uid   => 1914,
            gid   => 'lakassa',
            password  => '$6$VgWrNj3Z$Oh03zODE3dA3UD6ywU2QK7CCPfy8l76V5NqTBzfgGG87Dwqs8dpIs7zkIehySv.xUmGreokqPYFMJInEZPjg2/',
            comment   => '$hostname lakassa',
            #groups   => ["lakassa","wheel"],
            require   => Package['ruby-shadow'],
            managehome  => true,
    }


    user { 'astarov':
            ensure    => present,
            uid   => 1916,
            gid   => 'astarov',
            password  => '$6$FYXtn1qX$2PFvRQ5l6SfNUXHz7C0xS8yCBaAnf1HaEBqMW4pV9DV6YT1acyoRhdOM8ZeMospbkLDgPTTT.058g.gGnZ32i0',
            comment   => '$hostname astarov',
            #groups   => ["astarov","wheel"],
            require   => Package['ruby-shadow'],
            managehome  => true,
    }

    user { 'tslankard':
            ensure    => present,
            uid   => 1917,
            gid   => 'tslankard',
            password  => '$6$xjLouVT6$cA1AEqOHB.hKjd3POMAlpQKVHn8g1x4balrHOupyq0i7ClgaDwItiDnlkjw9.zarPlIe708PxN8n7w/HGd.nQ.',
            comment   => '$hostname tslankard',
            #groups   => ["tslankard","wheel"],
            require   => Package['ruby-shadow'],
            managehome  => true,
    }


    user { 'root':
      comment   => $hostname,
                  password  => '$6$u.6FvccE$qkwBWHR.3sEZyGnsCUKp9I67MJx575bi1I9bBCqSbK01MjdemauffttyGeGF91TncEEWOob0OLOQAStGhc5/e/',
    }


    package { 'ruby-shadow':
      ensure    => present,
      provider  => yum,
    }

    package { 'oddjob':
      ensure    => present,
      provider  => yum,
    }

    service { 'oddjobd':
                  ensure          => "running",
                  enable          => "true",
      require   => Package['oddjob'],
      hasstatus => true,
    }


    file { '/home/users':
      ensure    => directory,
      owner   => root,
      group   => root,
      mode    => 777,
    }

    file { [ '/home/rcsbot/.ssh' ]:
            mode            => 700,
            owner           => rcsbot,
            group           => rcsbot,
            ensure          => directory,
            require         => User['rcsbot'],
    }

    file { '/home/rcsbot/.ssh/authorized_keys':
           # path            => "/home/rcsbot/.ssh/authorized_keys",
            ensure    => present,
            owner           => rcsbot,
            group           => rcsbot,
            mode            => 600,
            source          => 'puppet:///modules/users/authorized_keys.rcsbot',
            require         => User['rcsbot'],
    }

    file { '/home/rcsbot/.ssh/id_rsa':
            path            => "/home/rcsbot/.ssh/id_rsa",
            owner           => rcsbot,
            group           => rcsbot,
            mode            => 600,
            source          => 'puppet:///modules/users/id_rsa.rcsbot',
            require         => User['rcsbot'],
    }

    file { '/home/rcsbot/.bash_profile':
      ensure    => present,
      owner   => rcsbot,
      group   => rcsbot,
      mode    => 644,
      source    => 'puppet:///modules/users/rcsbot/.bash_profile.rcsbot',
      require   => User['rcsbot'],
    }

    file { '/etc/profile':
      ensure    => present,
                  owner   => root,
                  group   => root,
                  mode    => 644,
                  source    => 'puppet:///modules/users/profile',
    }
}
