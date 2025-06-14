"use client"

import {useContext, useState, createContext, Dispatch, SetStateAction} from "react";

interface AuthContextProps {
    user: boolean;
    setUser: Dispatch<SetStateAction<boolean>>;
}

const AuthContext = createContext<AuthContextProps | null>(null)

export const useAuthContext = () => {
    const context = useContext(AuthContext);
    if (!context) {
        throw new Error("useAuthContext must be used within AuthContext");
    }
    return context;
};

export function AuthProvider({ children }: { children: React.ReactNode }) {
    const [user, setUser] = useState(false);

    return (
        <AuthContext.Provider value={{
            user,
            setUser,
        }}>
            {children}
        </AuthContext.Provider>
    );
}