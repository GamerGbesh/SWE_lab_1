"use client";
import Link from "next/link";
import axios from "axios";
import { useState, MouseEvent } from "react";
import {useAuthContext} from "@/app/context/AuthContext";
import { useRouter } from 'next/navigation';


export default function Page(){
    const [email, setEmail] = useState("");
    const [password, setPassword] = useState("");
    const [passwordConfirm, setPasswordConfirm] = useState("");
    const [username, setUsername] = useState("");
    const { setUser } = useAuthContext();
    const router = useRouter();

    async function onclick(e: MouseEvent<HTMLButtonElement>){
        e.preventDefault();
        try{
            const response = await axios.post("http://127.0.0.1:5000/signup", {
                email,
                password,
                password2:passwordConfirm,
                username
            })
            console.log(response)
            setUser(true)
            router.push("/dashboard");
        }
        catch(err){
            console.log(err);
        }
    }

    return (
        <div className="max-w-md mx-auto p-4 bg-gray-200 shadow-2xl rounded-lg relative top-30">
            <div className="grid place-items-center h-full gap-4">
                <label htmlFor="username">Username</label>
                <input type={"text"} placeholder={"Username"}
                       id={"username"} name={"username"}
                       onChange={(e) => setUsername(e.target.value)}/>

                <label htmlFor="email">Email</label>
                <input type="email"
                       placeholder={"Email"}
                       id={"email"} name={"email"}
                       onChange={(e) => setEmail(e.target.value)}/>

                <label htmlFor="password">Password</label>
                <input type="password" placeholder={"Password"}
                       id={"password"} name={"password"}
                        onChange={(e) => setPassword(e.target.value)}/>

                <label htmlFor="password2">Confirm Password</label>
                <input type="password" placeholder={"Confirm Password"} id={"password2"} name={"password2"}
                onChange={(e) => setPasswordConfirm(e.target.value)}/>

                <button type={"submit"} className={"bg-blue-900 p-1 rounded-2xl px-6  cursor-pointer"}
                        onClick={onclick}
                >Sign up</button>
                
                <p>Already have an account? <Link href={"/login"} className={"text-blue-700"}><span>Login</span></Link></p>
            </div>
        </div>
    )
}