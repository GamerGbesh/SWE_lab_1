"use client";

import Link from "next/link";
import axios from "axios";
import {useState, MouseEvent} from "react";
import {useAuthContext} from "@/app/context/AuthContext";
import { useRouter } from 'next/navigation';

export default function Page() {
    const [username, setUsername] = useState("");
    const [password, setPassword] = useState("");
    const { setUser } = useAuthContext();
    const router = useRouter();

    async function onclick(e: MouseEvent<HTMLButtonElement>) {
        e.preventDefault();
        try{
            const response = await axios.post("http://127.0.0.1:5000/login",{
                username,
                password,
            })
            console.log(response)
            setUser(true)
            router.push("/dashboard");

        } catch (err) {
            console.error(err);
        }
    }

    return (
        <div className="max-w-md mx-auto p-4 bg-gray-200 shadow-2xl rounded-lg relative top-30">
            <div className="grid place-items-center h-full gap-4">
                <label htmlFor="username">Username</label>
                <input type={"text"} placeholder={"Username"} id={"username"}
                onChange={(event) => setUsername(event.target.value)}/>

                <label htmlFor="password">Password</label>
                <input type="password" placeholder={"Password"} id={"password"}
                onChange={(event) => setPassword(event.target.value)}/>

                <button type={"submit"} className={"bg-blue-900 p-1 rounded-2xl px-6 cursor-pointer"}
                onClick={onclick}>Login</button>
                <p>Don&#39;t have an account? <Link href={"/signup"} className={"text-blue-700"}><span>Signup</span></Link></p>

            </div>
        </div>
    );
}