package main

import (
	"context"
	"fmt"
	"github.com/jackc/pgx/v5"
	_ "github.com/joho/godotenv/autoload"
	"os"
)

/*
1. User creates account and logs in.
	- DB checks if user already exists. Denies if they do and makes them sign in.
	- User gets token that then is used for routes.
	- Must verify email is unique, get their first and last name, and DOB.
2. User fills out first-time user form if they're new.
	- Must have a picture, interests, if interested in girl or boy.
3. User can begin swiping.
	- If user likes, save like. If other person already liked, show matched.
	- If dislikes, save dislike and don't show that user ever again.
4. If user matches, allow them to message other user.
	- Open websocket if they enter a chat, close when they leave it.
*/``

func main() {
	ctx := context.Background()
	conn, err := pgx.Connect(ctx, os.Getenv("DATABASE_URL"))
	if err != nil {
		_, _ = fmt.Fprintf(os.Stderr, "Unable to connect to database: %v\n", err)
		os.Exit(1)
	}
	defer conn.Close(ctx)

	var greeting string
	err = conn.QueryRow(context.Background(), "select 'Hello, world!'").Scan(&greeting)
	if err != nil {
		fmt.Fprintf(os.Stderr, "QueryRow failed: %v\n", err)
		os.Exit(1)
	}

	fmt.Println(greeting)

}
