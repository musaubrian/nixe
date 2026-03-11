#!/usr/bin/env fish

# Yanked from Tsoding infiltrate.sh

set -gx PG_VER 17.2
set -gx PGS_PREFIX "$HOME/thirdparty/pgs"
set -gx PGDATA "$PGS_PREFIX/data/db"
set -gx PGHOST "127.0.0.1"
set -gx PGUSER postgres
set -gx PGPASSWORD localpass
set -gx PATH "$PGS_PREFIX/pkg/postgresql-$PG_VER/bin" $PATH

function db-start
    pg_ctl -D $PGDATA -l "$PGS_PREFIX/data/logs/postgres.log" start
end

function db-stop
    pg_ctl -D $PGDATA stop
end

function db-status
    pg_ctl -D $PGDATA status
end

function db-logs
    tail -f "$PGS_PREFIX/data/logs/postgres.log"
end

function db-list
    psql -U postgres -h 127.0.0.1 -c '\l'
end

function db-create
    createdb -U postgres -h 127.0.0.1 $argv[1]
end

function db-drop
    dropdb -U postgres -h 127.0.0.1 $argv[1]
end

function db-psql
    psql -U postgres -h 127.0.0.1 $argv[1]
end

function db-setup
    sudo pacman -S --needed git pkg-config gcc icu bison flex readline zlib

    set pkg "$PGS_PREFIX/pkg/postgresql-$PG_VER"
    set src "$PGS_PREFIX/src/postgresql-$PG_VER"

    set -gx PATH "$pkg/bin" $PATH

    if not test -d $pkg
        mkdir -vp "$PGS_PREFIX/src"

        if not test -d $src
            pushd "$PGS_PREFIX/src"
            wget "https://ftp.postgresql.org/pub/source/v$PG_VER/postgresql-$PG_VER.tar.gz"
            tar xzvf "postgresql-$PG_VER.tar.gz"
            popd
        else
            echo "$src already exists, skipping download"
        end

        pushd $src
        ./configure --prefix=$pkg --without-icu CFLAGS="-std=c17"
        make -j(nproc)
        make install
        popd
    else
        echo "$pkg already exists, skipping build"
    end

    mkdir -vp "$PGS_PREFIX/data/logs"

    if not test -d $PGDATA
        echo "localpass" > /tmp/pgpass
        initdb -D $PGDATA -U postgres --auth=md5 --pwfile=/tmp/pgpass
        rm /tmp/pgpass
    else
        echo "$PGDATA already exists, skipping initdb"
    end
end

function db-clean
    rm -rf "$PGS_PREFIX/src/postgresql-$PG_VER"
end

function db-tidy
    db-stop
    rm -rf "$PGS_PREFIX/pkg/postgresql-$PG_VER"
    rm -rf "$PGS_PREFIX/data"
    db-clean
    db-setup
end

function db-nuke
    db-stop
    rm -rfv "$PGS_PREFIX"
end

function db-info
    echo "PG Version:  $PG_VER"
    echo "Prefix:      $PGS_PREFIX"
    echo "Data:        $PGDATA"
    echo "Host:        $PGHOST"
    echo "URL:         postgresql://postgres:$PGPASSWORD@$PGHOST/<dbname>"
    db-status
end
