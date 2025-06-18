"use client"

import Link from "next/link";
import { useActionState, useEffect, useState } from "react";
import loginUser from "@/app/login/actions";
import { redirect } from "next/navigation";

import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { faEye, faEyeSlash } from "@fortawesome/free-solid-svg-icons";

const initialMessage = { success: false, message: "" };

export default function Login() {
    const [state, formState] = useActionState(loginUser, initialMessage);
    const [inputType, setInputType] = useState("password");

    useEffect(() => {
        if (state.success) {
            redirect("/");
        }
    }, [state.success]);

    const togglePassword = () => {
        setInputType(prev => prev === "password" ? "text" : "password");
    };

    return (
        <div className="max-w-md mx-auto p-4 bg-gray-200 shadow-2xl rounded-lg relative top-30">
            <form action={formState} className="grid place-items-center h-full gap-4">
                <label htmlFor="username">Username</label>
                <input type="text" placeholder="Username" id="username" name="username"
                       className="border rounded-2xl px-4 border-blue-300"/>

                <label htmlFor="password">Password</label>
                <div className="relative flex items-center justify-center">
                    <input type={inputType} placeholder="Password" id="password" name="password"
                           className="border rounded-2xl px-4 pr-10 w-full border-blue-300"/>
                    <button type="button" onClick={togglePassword}
                            className="absolute right-4 text-gray-600">
                        <FontAwesomeIcon icon={inputType === "password" ? faEye : faEyeSlash}/>
                    </button>
                </div>

                <button type="submit"
                        className="bg-blue-900 p-1 rounded-2xl px-6 cursor-pointer text-white">Login
                </button>
                <p>Don&#39;t have an account?
                    <Link href="/register" className="text-blue-700 ml-1">
                        <span>Signup</span>
                    </Link>
                </p>
            </form>

            {state.message && (
                <p className={`mt-2 text-sm ${state.success ? 'text-green-600' : 'text-red-600'}`}>
                    {state.message}
                </p>
            )}
        </div>
    );
}